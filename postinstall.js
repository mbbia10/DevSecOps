// postinstall.js
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

console.log('🔧 Verificando e corrigindo vulnerabilidades...');

// Forçar versões seguras mesmo após a instalação
try {
  execSync('npm install glob@10.5.0 cross-spawn@7.0.5 --no-save --legacy-peer-deps', { 
    stdio: 'inherit' 
  });
  console.log('✅ Versões seguras forçadas com sucesso!');
} catch (error) {
  console.log('⚠️  Não foi possível forçar todas as versões, continuando...');
}

// Verificar se funcionou
console.log('\n📊 Versões instaladas:');
execSync('npm list glob cross-spawn --depth=0', { stdio: 'inherit' });