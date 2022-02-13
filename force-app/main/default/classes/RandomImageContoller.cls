public with sharing class RandomImageContoller {

    @AuraEnabled(cacheable=true)
    public static RandomImageData getRandomImageData(){
        String key = unsplashkey__c.getOrgDefaults().key__c;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.unsplash.com/photos/random?client_id=' + key + '&orientation=squarish');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
            RandomImageData data = new RandomImageData();
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Integer likes = (Integer) results.get('likes');
            
            Map<String, Object> urls = (Map<String, Object>) results.get('urls');
            String imageUrl = (String) urls.get('small_s3');

            Map<String, Object> user = (Map<String, Object>) results.get('user');
            String name = (String) user.get('name');
            String portfolio = (String) user.get('portfolio_url');

            data.image = imageUrl;
            data.numOfLikes = likes;
            data.photographerName = name;
            data.portfolio = portfolio;
        
            return data;
        }
        return new RandomImageData();
    }

    public class RandomImageData{
        @AuraEnabled
        public String image;
        
        @AuraEnabled
        public Integer numOfLikes;
        
        @AuraEnabled
        public String photographerName;
        
        @AuraEnabled
        public String portfolio;
    }
}
