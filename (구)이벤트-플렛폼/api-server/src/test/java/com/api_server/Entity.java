import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Event {
    @Id
    private String id;
    private String type;
    private String payload;
    // getters / setters
}
