public with sharing class ProductSearchController {
    
    @AuraEnabled(cacheable=true)
    public static List<Product2> searchProducts(String searchTerm) {
        // Escape special characters from the search term
        String searchPattern = '%' + searchTerm + '%';
        
        // Query the Product2 object
        List<Product2> products = [
            SELECT Id, Name, ProductCode 
            FROM Product2 
            WHERE Name LIKE :searchPattern 
            LIMIT 10
        ];
        
        return products;
    }
}