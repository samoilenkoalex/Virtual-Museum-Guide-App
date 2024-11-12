# Virtual Museum Guide App
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)]()
[![Maintaner](https://img.shields.io/static/v1?label=Oleksandr%20Samoilenko&message=Maintainer&color=red)](mailto:oleksandr.samoilenko@extrawest.com)
[![Ask Me Anything !](https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg)]()
![GitHub license](https://img.shields.io/github/license/Naereen/StrapDown.js.svg)
![GitHub release](https://img.shields.io/badge/release-v1.0.0-blue)

## PROJECT INFO
- **Flutter app with Art Collection API from Metropolitan Museum of Art**
- **This app allows you to search for artworks from Metropolitan Museum of Art  and get AI generated information about them**

## Features
- Metropolitan Museum of Art API: https://metmuseum.github.io/
- Llama vision model: meta-llama/Llama-3.2-90B-Vision-Instruct-Turbo

## Preview

1. Search artwork
   <img src="" alt="Preview" width="400"/>

2. Generated description 
   <img src="" alt="Preview" width="400"/>


## Installing:
**1. Clone this repo to your folder:**

```
git clone https://gitlab.extrawest.com/i-training/flutter/virtual-museum-guide-app
```

**2. Change current directory to the cloned folder:**

```
cd virtual-museum-guide-app/mobile
```

**3. Get packages**

```
flutter pub get
```

## Setup Server
**1. Open server folder:**

```
cd virtual-museum-guide-app/server
```

**2. In the root of server file create .env file and add the following variables:**

```
TOGETHER_API_KEY='YOUR_TOGETHER_API_KEY'
```


**2. Change server path in flutter project:**
Go to app/lib/services/api_service.dart and change the baseUrl to your server path

Now you can use the app


Created by Oleksandr Samoilenko

[Extrawest.com](https://www.extrawest.com), 2024

