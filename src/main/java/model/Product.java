package model;

public class Product {
    private int id;
    private String name;
    private String description;
    private int quantity;
    private int categoryId;
    private String categoryName;
    private byte[] image;
    private String imageBase64; // This field must exist
    
    // Constructors
    public Product() {}
    
    public Product(int id, String name, String description, int quantity, int categoryId, byte[] image) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.quantity = quantity;
        this.categoryId = categoryId;
        this.image = image;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
    
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
    
    public byte[] getImage() { return image; }
    public void setImage(byte[] image) { this.image = image; }
    
    // These are the critical methods that must exist
    public String getImageBase64() { return imageBase64; }
    public void setImageBase64(String imageBase64) { 
        this.imageBase64 = imageBase64; 
    }
}