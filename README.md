# idempiere-login
Esta es una aplicación móvil desarrollada en Flutter que se integra con el backend del sistema ERP iDempiere. La aplicación implementa un sistema de autenticación que ofrece dos modalidades de inicio de sesión:

   One-step Log-in: Permite a los usuarios autenticarse proporcionando credenciales junto con parámetros adicionales como cliente, rol, organización, almacén y lenguaje. Esto ofrece una experiencia de autenticación más personalizada, adaptada a la estructura organizacional del usuario.

   Normal Log-in: Un método más simple que permite a los usuarios iniciar sesión únicamente con su nombre de usuario y contraseña.

La autenticación exitosa devuelve un token de autorización Bearer, que se utiliza para acceder a las funciones protegidas de la aplicación.
