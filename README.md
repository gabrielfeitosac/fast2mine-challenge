## 📲 Installation

### 1. Download the APK

👉 [Click here to download the APK](https://drive.google.com/drive/folders/1bRJv8ULnhuA4ipXgMyQsnbOYu9P0fxIq)

### 2. Install

- Enable the **"Unknown Sources"** permission on your device.
- Install the APK and open the app normally.

---

## ⚙️ How to Use

1. Open the app.
2. Click the **"SIMULATE NEXT READING"** button to perform a simulated data reading.
3. Watch the interface update in real time.
4. When a cycle is completed, it will be saved locally.
5. Click **"SYNC DATA"** to export the synchronization simulation JSON.

---

## 🧠 Architecture & Technical Decisions

- **SQFlite** used for local data persistence.
- Clean Architecture implemented using **DataSources**, **Repositories**, and **UseCases**.
- Folder structure organized according to Clean Architecture: **Features**, **Data**, **Domain**, **Presentation**.
- **GetIt** package used for managing Singleton instances.
- **JsonSerializable** and **JsonAnnotation** packages used to help generate model classes.
- GPS and Step data are stored as JSON in the local database using custom JSON converters.

---

## 💾 Storage Location

The file generated with the synchronized data is:

- **📁 sync_servidor.jsonl**
- **Device path:** `/storage/emulated/0/Download/sync_servidor.jsonl` (Downloads folder)

> To access the file, use tools like Android Studio or the device's own file manager.

---

## ❓ Technical Questions

- Was automatic validation of multiple sequential cycles required? (Repeat the process)
- Is dynamic user import of `.jsonl` files needed? (FilePicker)
- The truck must be stationary for 5 seconds to be in the `IN LOADING QUEUE` step, but on the first reading I don’t have a previous timestamp to compare — which step should be considered?
- Should the app maintain the current step after being closed?
