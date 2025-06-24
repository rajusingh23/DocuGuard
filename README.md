# 📱 DocuGuard – iOS App

**DocuGuard** is an iOS application built using **SwiftUI** and **MVVM architecture**. It includes secure Google Sign-In, offline Core Data storage, local notifications, image handling, and an integrated PDF viewer.

---

## 🚀 Features

### ✅ User Authentication
- Google Sign-In via Firebase Authentication
- Saves user details to Core Data

### ✅ PDF Report Viewer
- Displays a remote PDF using PDFKit
- URL: [Balance Sheet](https://fssservices.bookxpert.co/GeneratedPDF/Companies/nadc/2024-2025/BalanceSheet.pdf)

### ✅ Image Handling
- Capture images from the camera
- Select photos from the device gallery
- Display selected image in the app

### ✅ API Integration + Core Data
- Fetch data from: [https://api.restful-api.dev/objects](https://api.restful-api.dev/objects)
- Save to Core Data
- Supports update and delete
- Error handling and validations included

### ✅ Local Notifications
- When an API item is deleted, a local notification is triggered with the item’s name
- Users can enable/disable notifications via the Settings screen

---

## 🧱 Architecture

- ✅ **MVVM** design pattern
- ✅ **SwiftUI** for UI
- ✅ **Combine** for reactive updates
- ✅ **Core Data** for offline persistence
- ✅ **PDFKit** for document viewing
- ✅ **UIKit bridging** for camera/photo handling

---

## 🎨 UI/UX

- Adaptive layout for Light and Dark Mode
- Modern SwiftUI design patterns
- Reusable views and modifiers
- Clean navigation with `NavigationStack`

---

## 🔒 Permissions

App uses the following iOS permissions:

- `NSCameraUsageDescription`
- `NSPhotoLibraryUsageDescription`
- `NSUserTrackingUsageDescription` (if needed for Firebase Analytics)


---

## 🧪 Requirements

- Xcode 15+
- iOS 16+
- Firebase iOS SDK (Authentication)

---

