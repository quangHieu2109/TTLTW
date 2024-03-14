package dto;

public class UserGoogleDTO {
    private String id;
    private String email;
    private String name;
    private String picture;
    private String given_name;
    private String family_name;
    private String verified_email;

    public UserGoogleDTO(String id, String email, String name, String picture, String given_name, String family_name, String verified_email) {
        this.id = id;
        this.email = email;
        this.name = name;
        this.picture = picture;
        this.given_name = given_name;
        this.family_name = family_name;
        this.verified_email = verified_email;
    }

    @Override
    public String toString() {
        return "UserGoogleDTO{" +
                "id='" + id + '\'' +
                ", email='" + email + '\'' +
                ", name='" + name + '\'' +
                ", picture='" + picture + '\'' +
                ", given_name='" + given_name + '\'' +
                ", family_name='" + family_name + '\'' +
                ", verified_email='" + verified_email + '\'' +
                '}';
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public String getGiven_name() {
        return given_name;
    }

    public void setGiven_name(String given_name) {
        this.given_name = given_name;
    }

    public String getFamily_name() {
        return family_name;
    }

    public void setFamily_name(String family_name) {
        this.family_name = family_name;
    }

    public String getVerified_email() {
        return verified_email;
    }

    public void setVerified_email(String verified_email) {
        this.verified_email = verified_email;
    }
}