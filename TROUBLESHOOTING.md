# 🆘 Troubleshooting - Guia de Resolução de Problemas

## ❌ Problema: "Gem not found: tailwindcss-rails"

### Solução:
```bash
# Limpe cache do bundler
rm -rf Gemfile.lock

# Reinstale tudo
bundle install

# Tente novamente
rails tailwindcss:install
```

---

## ❌ Problema: CSS não está sendo aplicado

### Solução 1: Limpe assets compilados
```bash
rails assets:clobber
./bin/dev
```

### Solução 2: Reinicie o servidor
```bash
# Matalize o processo (Ctrl+C)
# Execute novamente:
./bin/dev
```

### Solução 3: Abra em nova aba do navegador
- Às vezes precisa fazer hard refresh: `Ctrl+Shift+R` ou `Cmd+Shift+R`

---

## ❌ Problema: "Command not found: ./bin/dev"

### Solução:
```bash
# Dê permissão de execução
chmod +x bin/dev
chmod +x bin/rails

# Tente novamente
./bin/dev
```

Ou use:
```bash
bundle exec rails server
```

---

## ❌ Problema: Tailwind não carrega no navegador

### Solução:
1. Abra Developer Tools (F12 ou Cmd+Option+I)
2. Vá para a aba **Network**
3. Procure por `application.css`
4. Se não aparecer, o arquivo pode não ter sido compilado

Para compilar manualmente:
```bash
rails tailwindcss:build
```

---

## ❌ Problema: Ícones SVG não aparecem

### Solução:
Os ícones estão inline no HTML. Se não aparecer:
1. Verifique o console do navegador (F12)
2. Procure por erros de CSS
3. Limpe o cache do navegador

```bash
# Se necessário, recompile CSS:
rails assets:precompile
```

---

## ❌ Problema: Layout quebrado em mobile

### Solução:
Verifique se a meta tag está presente no `application.html.erb`:
```html
<meta name="viewport" content="width=device-width,initial-scale=1">
```

Já está presente. Se ainda não funcionar, force refresh:
- Mobile: Feche e abra o navegador novamente

---

## ❌ Problema: Drag & Drop do upload não funciona

### Solução:
Verificar console do navegador (F12 → Console):
```javascript
// Se não funcionar, tente manual:
document.getElementById('file_input').click()
```

O arquivo `homes/new.html.erb` tem o código. Se não funcionar:
1. Verifique se o navegador suporta HTML5 (todos suportam)
2. Tente fazer upload clicando no input manualmente
3. Limpe cache do navegador

---

## ❌ Problema: Tabela de customers não aparece

### Solução 1: Nenhum customer no banco
- Suba um arquivo para criar customers
- Vá para `/customers`

### Solução 2: Erro de renderização
Verifique o console:
```bash
# Ver logs do servidor
tail -f log/development.log
```

Procure por erros de syntax no ERB.

---

## ❌ Problema: Animações muito lentas ou travando

### Solução:
1. Verifique a performance:
   - Abra DevTools → Performance
   - Grave uma ação
   - Verifique FPS

2. Se estiver lento:
   - Desabilite `animate-pulse` em `_logs.html.erb`
   - Use CSS nativo ao invés de classes dinâmicas

### Código para desabilitar animação:
```erb
<!-- Antes -->
<div class="w-12 h-12 bg-yellow-100 rounded-full flex items-center justify-center flex-shrink-0 animate-pulse">

<!-- Depois -->
<div class="w-12 h-12 bg-yellow-100 rounded-full flex items-center justify-center flex-shrink-0">
```

---

## ❌ Problema: Cores estão erradas/diferentes

### Solução:
1. Abra `tailwind.config.js`
2. Verifique os nomes das cores (case-sensitive)
3. Cores disponíveis:
   - `blue-50` até `blue-900`
   - `indigo-50` até `indigo-900`
   - `slate-50` até `slate-900`
   - etc.

Se quiser mudar uma cor global:
```js
// tailwind.config.js
theme: {
  colors: {
    'blue': {
      '600': '#2563eb', // Mude para a cor que quiser
    }
  }
}
```

---

## ❌ Problema: "Tailwind CSS is not defined" (JavaScript)

### Solução:
Se ver este erro no console, significa que você está tentando usar Tailwind via JavaScript (não é necessário). Ignore ou remova a linha que está causando.

Tailwind funciona apenas via CSS, não precisa de import/require.

---

## ❌ Problema: Sass error / CSS syntax error

### Solução:
Verifique o arquivo `application.css`:
```css
/* Deve ter exatamente assim: */
@import "tailwindcss/base";
@import "tailwindcss/components";
@import "tailwindcss/utilities";
```

Se houver erro:
```bash
# Recompile
rails assets:clobber
rails assets:precompile
```

---

## ❌ Problema: "Cannot find module 'tailwindcss'"

### Solução:
Este erro é de Node.js, não do Rails. Significa que:
1. Node não está instalado, OU
2. Dependências Node não foram instaladas

Tente:
```bash
bundle install --redownload
rails tailwindcss:install
```

---

## ✅ Verificação de Saúde

Use este checklist para confirmar que tudo está ok:

### Frontend:
- [ ] Página home carrega com design bonito
- [ ] Upload é possível (manual ou drag-drop)
- [ ] Botões possuem efeito hover (sombra/escurece)
- [ ] Navbar aparece no topo
- [ ] Mensagens de sucesso/erro são coloridas

### Dados:
- [ ] Upload cria log
- [ ] Log aparece em `/process_logs`
- [ ] Customers aparecem em `/process_logs`
- [ ] Navegação entre páginas funciona

### Mobile:
- [ ] Layout se adapta em telas pequenas
- [ ] Botões são clicáveis
- [ ] Texto é legível
- [ ] Sem overflow horizontal

---

## 🔍 Debug Avançado

### Ver logs em tempo real:
```bash
tail -f log/development.log
```

### Abrir console do Rails:
```bash
rails console
```

### Compilar CSS manualmente:
```bash
rails tailwindcss:build
```

### Assistir mudanças CSS (live):
```bash
rails tailwindcss:watch
```

---

## 📞 Se Nada Funcionar

1. **Feche tudo:**
   ```bash
   # Matalize servidor (Ctrl+C)
   # Feche navegador
   ```

2. **Limpe tudo:**
   ```bash
   bundle exec rake assets:clobber
   rm -rf app/assets/builds/*
   ```

3. **Reinstale:**
   ```bash
   bundle install
   rails tailwindcss:install
   ```

4. **Inicie novamente:**
   ```bash
   ./bin/dev
   ```

5. **Abra navegador:**
   - http://localhost:3000 (não localhost:3000/assets)
   - Hard refresh: `Ctrl+Shift+R`

---

## 🆘 Último Recurso

Se ainda não funcionar, execute:
```bash
# Método nuclear (recria tudo)
bundle clean
bundle install
rails assets:clobber
rails assets:precompile
rails db:migrate
./bin/dev
```

---

## 📚 Recursos Úteis

- **[Tailwind CSS Docs](https://tailwindcss.com/docs)**
- **[Rails Guides - Asset Pipeline](https://guides.rubyonrails.org/asset_pipeline.html)**
- **[tailwindcss-rails GitHub](https://github.com/rails/tailwindcss-rails)**
- **[MDN Web Docs](https://developer.mozilla.org/)**

---

## 💡 Dicas Finais

1. **Use Chrome DevTools** - F12 é seu melhor amigo
2. **Limpe cache regularmente** - `Ctrl+Shift+Delete`
3. **Reinicie servidor** - Às vezes funciona (e.g., macOS)
4. **Leia os logs** - Eles dirão o que está errado
5. **Google é seu amigo** - Copie o erro e procure no Google

---

**Boa sorte! Você consegue! 🚀**
