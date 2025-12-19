

require 'sidekiq'
require_relative '../../app/sidekiq/process_email_job'





RSpec.describe ProcessEmailJob, type: :job do
  let(:email_file) { "email.eml" }
  let(:log) { double("ProcessLog", id: 1) }

  before do
    allow(ProcessLog).to receive(:create).and_return(log)
    allow(log).to receive(:update)
    allow(Turbo::StreamsChannel).to receive(:broadcast_replace_to)
    allow(Turbo::StreamsChannel).to receive(:broadcast_update_to)
    allow(Kernel).to receive(:sleep) # evita delay nos testes
  end

  context "when processing succeeds" do
    let(:result) { { name: "João", email: "joao@email.com" } }
    let(:process_email_instance) { double("ProcessEmail", process: result) }
    let(:customer) { double("Customer", save: true) }

    before do
      allow(ProcessEmail).to receive(:new).with(email_file).and_return(process_email_instance)
      allow(Customer).to receive(:new).with(result).and_return(customer)
    end

    it "creates log, saves customer, updates log, and broadcasts" do
      described_class.new.perform(email_file)

      expect(ProcessLog).to have_received(:create).with(
        status: "pending",
        filename: "email.eml",
        error: nil,
        extracteddata: nil
      )
      expect(customer).to have_received(:save)
      expect(log).to have_received(:update).with(
        status: "completed",
        extracteddata: result
      )
      expect(Turbo::StreamsChannel).to have_received(:broadcast_replace_to)
      expect(Turbo::StreamsChannel).to have_received(:broadcast_update_to)
    end
  end

  context "when process returns nil" do
    let(:result) { nil }
    let(:process_email_instance) { double("ProcessEmail", process: result) }

    before do
      allow(ProcessEmail).to receive(:new).with(email_file).and_return(process_email_instance)
    end

    it "updates log as failed and broadcasts" do
      described_class.new.perform(email_file)

      expect(log).to have_received(:update).with(
        status: "failed",
        error: "Nenhum dado extraído do arquivo"
      )
      expect(Turbo::StreamsChannel).to have_received(:broadcast_replace_to)
      expect(Turbo::StreamsChannel).to have_received(:broadcast_update_to)
    end
  end

  context "when customer fails to save" do
    let(:result) { { name: "João", email: "joao@email.com" } }
    let(:process_email_instance) { double("ProcessEmail", process: result) }
    let(:customer) { double("Customer", save: false, errors: double(full_messages: ["Erro"])) }

    before do
      allow(ProcessEmail).to receive(:new).with(email_file).and_return(process_email_instance)
      allow(Customer).to receive(:new).with(result).and_return(customer)
    end

    it "updates log as failed with customer errors" do
      described_class.new.perform(email_file)

      expect(log).to have_received(:update).with(
        status: "failed",
        error: "Erro"
      )
    end
  end

  context "when ProcessEmail raises error" do
    before do
      allow(ProcessEmail).to receive(:new).with(email_file).and_raise(RuntimeError.new("Falha"))
    end

    it "updates log as failed with exception" do
      described_class.new.perform(email_file)

      expect(log).to have_received(:update).with(
        status: "failed",
        error: "Falha"
      )
    end
  end
end
