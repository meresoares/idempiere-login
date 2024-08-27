# idempiere-login
Esta es una aplicación móvil desarrollada en Flutter que se integra con el backend del sistema ERP iDempiere. La aplicación implementa un sistema de autenticación que ofrece dos modalidades de inicio de sesión:

   One-step Log-in: Permite a los usuarios autenticarse proporcionando credenciales junto con parámetros adicionales como cliente, rol, organización, almacén y lenguaje. Esto ofrece una experiencia de autenticación más personalizada, adaptada a la estructura organizacional del usuario.

 Normal Log-in: Un método más simple que permite a los usuarios iniciar sesión únicamente con su nombre de usuario y contraseña.

La autenticación exitosa devuelve un token de autorización Bearer, que se utiliza para acceder a las funciones protegidas de la aplicación.

Documentación Utilizada:

Este proyecto utiliza los REST Web Services de iDempiere 
https://wiki.idempiere.org/en/REST_Web_Services#Login_in_to_get_your_Bearer_authorization_token
para el manejo de la autenticación y obtención del token de autorización Bearer.

Requisito:

Para compilar y ejecutar esta aplicación, se requiere tener instalado Flutter. Puedes seguir los pasos de instalación en la documentación oficial de Flutter https://docs.flutter.dev/get-started/install
