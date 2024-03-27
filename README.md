# Github Search

## Features

**Comprehensive Search**: Easily search across users and get their informations.
<br>
**Cross-platform Compatibility**: Designed to work smoothly on various devices and operating systems.

## Installation

To get started with GitHub Search, follow these steps:

1. Clone the repository:

```
git clone https://github.com/ST1NF00K/github-search.git
```

2. Navigate to the project directory:


```
cd github-search
```

3. Get the dependencies:

```
flutter pub get
```

4. Run the project

```
flutter run
```

## About the project

### Architecture

In this project I choose to separate the folders in modules (feature-first) and follow the Clean Architecture principles.

```
‣ lib
  ‣ src
    ‣ features
      ‣ feature1
        ‣ presentation
        ‣ application
        ‣ domain
        ‣ data
      ‣ feature2
        ‣ presentation
        ‣ application
        ‣ domain
        ‣ data
```


### Technologies

The packages used were:

**Dependency control**
- get_it

**Http Requests**
- dio

**Local database**
- sqflite
- path

**State Management**
- mobx
- flutter_mobx
- mobx_codegen
- build_runner

**Unit Testing**
- mockito
- http_mock_adapter
- sqflite_common_ffi

<br> <br>

![github_search](https://github.com/ST1NF00K/github-search/assets/33629714/8ac6ab57-e5b4-48ce-807a-bd533379ba17)
