import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class GenerarPasswordHash {
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String password = "admin123";
        String hash = encoder.encode(password);
        System.out.println("Password: " + password);
        System.out.println("Hash: " + hash);
        System.out.println("\nVerificación:");
        System.out.println("¿Coincide? " + encoder.matches(password, hash));
    }
}
