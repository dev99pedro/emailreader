#!/bin/bash
set -e

echo "=================================="
echo "🎨 Email Reader - Setup Tailwind"
echo "=================================="
echo ""

# Check if we're in the right directory
if [ ! -f "Gemfile" ]; then
    echo "❌ Erro: Gemfile não encontrado. Execute este script na raiz do projeto."
    exit 1
fi

echo "📦 1. Instalando dependências do Bundler..."
bundle install

echo ""
echo "🎨 2. Instalando Tailwind CSS..."
rails tailwindcss:install

echo ""
echo "✅ Setup completo!"
echo ""
echo "=================================="
echo "📋 Próximos passos:"
echo "=================================="
echo ""
echo "1. Inicie o servidor de desenvolvimento:"
echo "   ./bin/dev"
echo ""
echo "2. Abra seu navegador em:"
echo "   http://localhost:3000"
echo ""
echo "3. Comece a usar sua aplicação com a nova interface!"
echo ""
echo "=================================="
