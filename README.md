# De la Idea al Despliegue: Primeros Pasos con AWS DevTools

Demo para charla sobre CI/CD con AWS DevTools y GitHub.

## 🎯 Objetivo

Crear un pipeline simple que despliegue una aplicación serverless automáticamente al hacer `git push`.

## 🏗️ Arquitectura

```
GitHub → CodePipeline → CodeBuild (tests + deploy) → Lambda
```

## 📦 Componentes

- **GitHub**: Repositorio de código
- **CodePipeline**: Orquestación del pipeline
- **CodeBuild**: Ejecución de tests y despliegue
- **Lambda**: Función serverless (Node.js)

## 🚀 Setup Automático

```bash
./setup-infrastructure.sh
```

Este script crea:
- ✅ Función Lambda
- ✅ Roles IAM necesarios
- ✅ Bucket S3 para artefactos
- ✅ Proyecto CodeBuild

## 🔗 Crear Conexión GitHub

1. Ve a: https://console.aws.amazon.com/codesuite/settings/connections
2. Click **"Create connection"**
3. Selecciona **GitHub** → Autoriza
4. Copia el ARN de la conexión

## 🚀 Crear Pipeline

El pipeline ya está configurado. Solo necesitas:

```bash
# El pipeline se crea automáticamente al hacer push
git push origin main
```

**Ver pipeline:**
https://console.aws.amazon.com/codesuite/codepipeline/pipelines/DevOpsDemoPipeline/view

## 📁 Estructura del Proyecto

```
start-with-devops/
├── src/
│   └── index.js          # Lambda function
├── tests/
│   └── index.test.js     # Tests
├── buildspec.yml         # Config CodeBuild (tests + deploy)
└── package.json          # Dependencias
```

## 🧪 Testing Local

```bash
npm install
npm test
```

## 🎤 Demo en Vivo

### 1. Mostrar el código
```bash
code src/index.js      # Lambda simple
code buildspec.yml     # Pipeline as code
```

### 2. Hacer un cambio
```javascript
// En src/index.js
message: '¡Hola DevOps! VERSIÓN 2.0 - Demo en vivo',
version: '2.0.0'
```

### 3. Push y observar
```bash
git add src/index.js
git commit -m "Demo: versión 2.0"
git push origin main
```

### 4. Verificar
```bash
# Opción 1: Invocar directamente
aws lambda invoke --region us-east-1 \
  --function-name DevOpsDemoFunction \
  response.json && cat response.json | jq

# Opción 2: Usar Function URL (público)
curl https://sdxqiuxrvldh4xjzbw75czxe740lmxld.lambda-url.us-east-1.on.aws/
```

**Function URL:** https://sdxqiuxrvldh4xjzbw75czxe740lmxld.lambda-url.us-east-1.on.aws/

## 🎓 Conceptos Clave

- **CI/CD**: De código a producción automáticamente
- **Pipeline as Code**: buildspec.yml versionado
- **Serverless**: Sin gestión de servidores
- **Automatización Total**: git push → tests → deploy
