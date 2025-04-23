
# Configuración de Notificaciones por Correo en Jenkins (Gmail)

Este documento describe los pasos para configurar **Jenkins** y habilitar **notificaciones por correo electrónico** utilizando una cuenta de **Gmail**.

---

## Requisitos previos

- Jenkins instalado y en ejecución
- Plugin `Email Extension Plugin` instalado
- Cuenta de Gmail con verificación en dos pasos habilitada
- Acceso a la configuración global de Jenkins

---

## Paso 1: Instalar el plugin

1. Ir a **Manage Jenkins > Manage Plugins**
2. En la pestaña `Available`, buscar:
   Email Extension Plugin
3. Instalar y reiniciar Jenkins si se solicita

---

## Paso 2: Crear credenciales de Gmail

1. Ir a **Manage Jenkins > Credentials > (global) > Add Credentials**
2. Tipo: `Username with password`
3. Completar:

   - **Username**: tu-correo@gmail.com
   - **Password**: contraseña de aplicación generada en Gmail (ver paso 3)
   - **ID**: `gmail-creds` (o cualquier identificador personalizado)

---

## Paso 3: Generar contraseña de aplicación en Gmail

1. Ir a: https://myaccount.google.com/apppasswords
2. Seleccionar "Mail" como app y "Other" para nombre personalizado (ej. "Jenkins")
3. Copiar la contraseña generada
4. Usar esa contraseña al crear las credenciales en Jenkins

---

## Paso 4: Configurar SMTP de Gmail

1. Ir a **Manage Jenkins > Configure System**
2. Buscar la sección **Extended E-mail Notification**
3. Completar los campos:

| Campo                     | Valor                         |
|---------------------------|-------------------------------|
| SMTP server               | `smtp.gmail.com`              |
| SMTP port                 | `587`                         |
| Use SSL                   | (desactivado)                 |
| Use TLS                   | (activado)                    |
| SMTP Authentication       | ✅ marcado                    |
| Credentials               | Selecciona: `gmail-creds`     |
| Default user email suffix | (dejar vacío o usar @gmail.com) |

---

## Paso 5: Probar envío de correo

1. En la sección **Extended E-mail Notification**, clic en:

   Test configuration by sending test e-mail

2. Ingresar un correo de destino (puede ser el tuyo)
3. Verifica que llegue correctamente

---

## Paso 6: Agregar notificación al Jenkinsfile

Dentro del bloque `pipeline { ... }`, agrega:

(post block para success)

    emailext subject: "Build OK: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
             body: "El pipeline ${env.JOB_NAME} finalizó correctamente.\nLink: ${env.BUILD_URL}\nRama: ${env.BRANCH_NAME}",
             to: 'tu-correo@gmail.com'

(post block para failure)

    emailext subject: "Build FALLÓ: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
             body: "El pipeline ${env.JOB_NAME} ha fallado.\nLink: ${env.BUILD_URL}\nRama: ${env.BRANCH_NAME}",
             to: 'tu-correo@gmail.com'

---

## Resultado

Cada vez que se ejecute un pipeline:

- Si finaliza correctamente → recibirás un correo de confirmación
- Si falla en algún paso → recibirás un correo de alerta

---

## Autor

Franklin Cappa Ticona  
DevOps Engineer · DBCode Consulting
