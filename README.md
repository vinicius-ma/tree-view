# tractian_tree_view

This project is based on [Tractian](https://tractian.com/) purposed [challenge](https://github.com/tractian/challenges/blob/main/mobile/README.md) for the Mobile Software Engineer career.

# What Does this App Do?

This app uses the Flutter SDK to build the Android and iOS apps. The data **(will be)** consumed from the provided [fake API](https://fake-api.tractian.com/), from which it is possible to retrieve:

- A list of companies
- A list of a company's locations
- A list of a location's assets

Locations can be sub-locations, if it has a parent one. The same is true for assets.

The app has two main screens:
1. The Home Page
    - Where the user can select from which company they want to see the data;
2. The Asset Page
    - That shows a tree view of the company's locations and their assets.
    - Energy sensors have a special icon.
    - Sensors in critical status also have a special icon.
    - Both energy sensors and critical sensors can be showed in the tree view, isolated (filtered).
    - The user can also search for a specific asset name in the tree view.

// TODO: Add a video demonstrating the app opening for each company and selecting a filter.

// TODO: Describe which points of the project you would improve if you had the time to.