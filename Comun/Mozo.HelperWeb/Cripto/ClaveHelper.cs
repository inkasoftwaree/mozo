using BCrypt.Net;

namespace Mozo.HelperWeb.Cripto;

public static class ClaveHelper
{
    /// <summary>
    /// Genera el hash de una contraseña.
    /// </summary>
    public static string Hash(string password)
    {
        return BCrypt.Net.BCrypt.HashPassword(password);
    }

    /// <summary>
    /// Valida una contraseña contra el hash almacenado.
    /// </summary>
    public static bool Verify(string password, string hash)
    {
        return BCrypt.Net.BCrypt.Verify(password, hash);
    }
}

/*
 // Uso
Para guardar en base de datos
string clave = "xxxsss";

string hash = PasswordHelper.Hash(clave);

// Guardar hash en BD
usuario.NoClave = hash;
 
 */