class ProcessLog < ApplicationRecord
  STATUS = %w[pending completed failed]
  validates :status, inclusion: {in: STATUS}
  # sem essa validação o usuario poderia fazer por exemplo status: "banana". Com isso se ele fizer da falso

end
