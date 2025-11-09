import java.util.List;
import java.util.Scanner;

public class AddressBookApp {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        ContactDAO dao = new ContactDAO();
        int choice;

        System.out.println("========== SIMPLE ADDRESS BOOK ==========");

        do {
            System.out.println("\n1. Add Contact");
            System.out.println("2. View All Contacts");
            System.out.println("3. Edit Contact");
            System.out.println("4. Delete Contact");
            System.out.println("5. Exit");
            System.out.print("Enter choice: ");
            choice = sc.nextInt();
            sc.nextLine(); // consume newline

            switch (choice) {
                case 1:
                    System.out.print("Name: ");
                    String name = sc.nextLine();
                    System.out.print("Phone: ");
                    String phone = sc.nextLine();
                    System.out.print("Email: ");
                    String email = sc.nextLine();
                    System.out.print("Address: ");
                    String address = sc.nextLine();
                    dao.addContact(new Contact(name, phone, email, address));
                    break;

                case 2:
                    List<Contact> contacts = dao.getAllContacts();
                    System.out.printf("%-5s %-20s %-15s %-25s %-30s\n",
                            "ID", "Name", "Phone", "Email", "Address");
                    for (Contact c : contacts) {
                        System.out.println(c);
                    }
                    break;

                case 3:
                    System.out.print("Enter ID to Edit: ");
                    int editId = sc.nextInt();
                    sc.nextLine();
                    Contact existing = dao.getContactById(editId);
                    if (existing != null) {
                        System.out.print("New Name (" + existing.getName() + "): ");
                        String newName = sc.nextLine();
                        System.out.print("New Phone (" + existing.getPhone() + "): ");
                        String newPhone = sc.nextLine();
                        System.out.print("New Email (" + existing.getEmail() + "): ");
                        String newEmail = sc.nextLine();
                        System.out.print("New Address (" + existing.getAddress() + "): ");
                        String newAddress = sc.nextLine();

                        if (!newName.isEmpty()) existing.setName(newName);
                        if (!newPhone.isEmpty()) existing.setPhone(newPhone);
                        if (!newEmail.isEmpty()) existing.setEmail(newEmail);
                        if (!newAddress.isEmpty()) existing.setAddress(newAddress);

                        dao.updateContact(existing);
                    } else {
                        System.out.println("❌ Contact not found.");
                    }
                    break;

                case 4:
                    System.out.print("Enter ID to Delete: ");
                    int delId = sc.nextInt();
                    dao.deleteContact(delId);
                    break;

                case 5:
                    System.out.println("👋 Exiting Address Book. Goodbye!");
                    break;

                default:
                    System.out.println("Invalid choice. Try again.");
            }

        } while (choice != 5);

        sc.close();
    }
}

