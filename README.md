# clean_code_practice

Structure is divided into features and each feature contains 3 layers:
1. Presentation:
    - Widgets
    - Screens
    - Bloc or any state management to handle state
2. Domain :
    - Use Cases (encapsulate all the business logic of a particular use case of the app (e.g. GetConcreteNumberTrivia or GetRandomNumberTrivia))
    - Entities (This contains models to hold data)
    - Repository Abstract (actual implementation of the Repository Abstract is fulfilled in data layer)
3. Data: 
    - Repository implementation (at this place we decide to return data from API or Cache)
    - Data Sources (either RemoteDataSource or LocalDataSource. This returns model rather than entity.)
    - Models (this extends entities and implements some functionality like fromJson or toJson)
