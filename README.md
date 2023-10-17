# Flutter Task Manager Application

Elevate your productivity with Task Manager, a meticulously crafted task manager application designed to streamline your journey towards achieving your goals. With its sleek design and intuitive user interface, Task Manager redefines task management, making it an indispensable companion for both personal and professional endeavors.

## UI

![image](https://github.com/hredhayxz/Ostad-Flutter-App-Development-All/assets/60058949/952678e3-ac0b-419c-a4c0-acf0d43cac49)
![image](https://github.com/hredhayxz/Ostad-Flutter-App-Development-All/assets/60058949/91f70eff-951d-43b8-b50e-f22ee0ce10ed)
![image](https://github.com/hredhayxz/Ostad-Flutter-App-Development-All/assets/60058949/9a552ac4-4744-455e-bcbf-bc28a24b6376)
![image](https://github.com/hredhayxz/Ostad-Flutter-App-Development-All/assets/60058949/c89f65b0-b97f-4c39-adc5-27228f28527e)
![image](https://github.com/hredhayxz/Ostad-Flutter-App-Development-All/assets/60058949/a7e0f8d6-a7f6-41ce-87f0-18754fc46d8d)
![image](https://github.com/hredhayxz/Ostad-Flutter-App-Development-All/assets/60058949/0a9556cf-7d85-4e72-b6d7-37657b33ad72)
![image](https://github.com/hredhayxz/Ostad-Flutter-App-Development-All/assets/60058949/4c8dc207-96b1-4b43-b86a-9e47a31cd520)
![image](https://github.com/hredhayxz/Ostad-Flutter-App-Development-All/assets/60058949/3dc427cf-c562-40cc-92f5-359e67d2bf30)
![image](https://github.com/hredhayxz/Ostad-Flutter-App-Development-All/assets/60058949/59105734-1fea-4b5f-a62e-cde7f454d488)
![image](https://github.com/hredhayxz/Ostad-Flutter-App-Development-All/assets/60058949/c566b3c2-b899-430c-bb63-a9ccd47c541b)
![image](https://github.com/hredhayxz/Ostad-Flutter-App-Development-All/assets/60058949/d78d2753-8774-4a07-809c-070f85b74ce4)
![image](https://github.com/hredhayxz/Ostad-Flutter-App-Development-All/assets/60058949/e62080dc-31bc-4334-893d-e6496c96ec82)
![image](https://github.com/hredhayxz/Ostad-Flutter-App-Development-All/assets/60058949/fdb684ef-2d28-4850-960c-dfc35459460b)
![image](https://github.com/hredhayxz/Ostad-Flutter-App-Development-All/assets/60058949/847a2a6e-66ad-4d43-92fe-e7686f238401)
![image](https://github.com/hredhayxz/Ostad-Flutter-App-Development-All/assets/60058949/4691c3bf-2043-40fd-a636-5ea088431c89)


## Features of Task Manager

- **Seamless Onboarding:**
Embark on your productivity journey by creating your account through our user-friendly sign-up option. Forgot your password? No worries! Our secure log-in with password recovery feature ensures that you're always in control of your account.

- **Empowering Profile Updates:**
Customize your user experience and keep your information up-to-date effortlessly. The profile update option lets you modify your details and ensure your personal touch on the app.

- **Effortless Task Management:**
Add tasks effortlessly and embark on the path to success. The app initiates with a default category called "New," ensuring a swift start to your task list. With just a tap, transform your tasks into achievements.

- **Dynamic Task Status Updates:**
Progress Pal empowers you to manage your tasks dynamically. Move tasks between the "In Progress," "Completed," and "Cancelled" statuses effortlessly. A convenient bottom sheet pops up, allowing you to seamlessly shift tasks to the desired status.

- **Insightful Summary Card:**
Stay on top of your game with the Summary Card feature. It provides a quick snapshot of task distribution across the "In Progress," "Completed," and "Cancelled" categories. What's more? This handy card is accessible from any of the four main pages, keeping you informed at all times.

Task Manager isn't just an app; it's a tool that adapts to your rhythm, empowering you to make progress every step of the way. Whether you're a busy professional, a dedicated student, or someone striving to manage daily tasks effectively, Progress Pal caters to your unique needs.

Experience the future of task management. Download Task Manager today and unlock a world of organization, efficiency, and accomplishment. Your journey to success begins here.

## Getting Started

### Prerequisites

Ensure Flutter is installed on your machine. For installation instructions, refer to the official [Flutter website](https://flutter.dev/docs/get-started/install).

### Installation

Follow these steps to run the Task Manager Application:

1. Clone this repository to your local machine:

```bash
git clone https://github.com/hredhayxz/task_manager.git
```

2. Navigate to the project folder:

```bash
cd task_manager
```

3. Install dependencies:

```bash
flutter pub get
```

### How to Run

Connect your device or emulator and run the app using the following command:

```bash
flutter run
```
## Used Packages

Task Manager integrates the following packages to enhance functionality:

- `flutter_svg: ^2.0.7`: Display Scalable Vector Graphics (SVG) images.
- `pin_code_fields: ^8.0.1`: Easily implement secure PIN code input fields.
- `image_picker: ^1.0.1`: Enable users to select images from their devices.
- `http: ^1.1.0`: Perform HTTP requests and interact with APIs.
- `cached_network_image: ^3.2.3`: For display network image.
- `get: ^4.6.5`: Implement state management and dependency injection with the GetX library.
- `shared_preferences: ^2.2.0`: Local data storage and retrieval tasks using the shared preferences.



That sounds like a comprehensive project I am working on using the Flutter framework and the GetX state management library. GetX is a popular package in the Flutter community that offers a variety of utilities for state management, navigation, dependency injection, and more. It's great to using it for my project.

Since I mentioned that my app involves user accounts, tasks with statuses, and interactions with a REST API, here are some general tips and guidelines:

1. **Project Structure and Organization:**
   - Divide your project into logical folders and modules for better organization. For example, you might have folders for screens, controllers, models, services, and API calls.

2. **State Management with GetX:**
   - Utilize GetX's reactive state management features to manage the state of your app efficiently. The `GetXController` can help you manage state changes, reactivity, and binding of data to UI.

3. **Routing and Navigation:**
   - GetX provides a powerful routing system. Define your routes using `GetPage` objects, and navigate between screens using `Get.to()`, `Get.off()`, and other navigation methods provided by GetX.

4. **Dependency Injection:**
   - Use GetX's dependency injection to manage and provide instances of your controllers and services to your widgets. This helps in maintaining a clean separation of concerns.

5. **API Integration:**
   - Use the `http` package or another HTTP client to make REST API requests. Ensure that you handle API calls properly with error handling, loading indicators, and proper status code checks.

6. **User Authentication and Account Management:**
   - Implement user authentication using tokens, JWT, OAuth, or any other suitable method. GetX's reactive state management can be very helpful here.

7. **Task Management:**
   - Design your task-related screens with proper widgets to display and manage tasks. Use GetX's state management to reflect changes in task status and data.

8. **Error Handling and Validation:**
   - Implement error handling for API calls, form validations, and user interactions. Show appropriate error messages to the user when something goes wrong.

9. **Data Persistence:**
   - Consider using GetStorage or other database solutions to persist user data or app settings locally.

10. **User Interface:**
    - Design your app's user interface using Flutter widgets. Consider using GetX's reactive bindings to automatically update UI elements when the underlying data changes.

11. **Testing:**
    - Write unit tests and widget tests to ensure the reliability of your app's functionality.
   
12. **Documentation:**
    - Maintain clear and concise code comments and documentation to make your codebase understandable to you and others who might work on the project in the future.

   

## Contributors

- [Md Alhaz Mondal Hredhay](https://github.com/hredhayxz)

## Special Thanks

### A heartfelt thanks to my mentors:

[Rabbil Hasan](https://github.com/rupomsoft) for his enlightening prerecorded classes and [Md Rafat J. M.](https://github.com/RafatMeraz) for teaching me how to make UI like this and the API integration seamless.


