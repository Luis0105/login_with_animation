<h1 align="center">🧸 <span style="color:#f9a825;">Remix of Login Machine</span></h1>
<p align="center">
  <em>A Flutter project featuring an interactive login screen with real-time Rive animations</em>
</p>

---

This Flutter project presents an <strong>interactive and animated login screen</strong> featuring a character made in <strong>Rive</strong> that reacts dynamically to user actions.  
The character looks around while typing the email, <strong>covers its eyes</strong> when entering the password, and <strong>shows success or error animations</strong> depending on the login result.

Additionally, the character <strong>follows the user's typing with its eyes</strong> and includes a <strong>natural reaction delay</strong> when typing stops.  
To achieve this, several previously studied widgets were implemented and integrated properly.

---

### ✨ Main Features

👀 Character eye-tracking based on user input  
🙈 Eye-covering animation when typing the password  
✅ Success animation when credentials are correct  
❌ Error animation when credentials are incorrect  
🔄 Real-time reactions powered by Rive’s <em>State Machine</em>  
🧭 Responsive design adaptable to multiple screen sizes  

---

<h2 align="center">🎨 What is <span style="color:#00b4d8;">Rive</span>?</h2>

<p align="center">
  <em>
    Rive is a real-time interactive design and animation platform that lets you create dynamic motion graphics
    for apps, games, and websites.
  </em>
</p>

---

**Rive** allows developers and designers to build animations that 
<strong>respond instantly to user interactions</strong> — such as taps, text input, or state changes — 
without needing to rebuild the app.

Its main power lies in the use of <strong>State Machines</strong>, which connect logic to animation, 
making it possible to build <strong>truly interactive characters and UI elements</strong>.

🧩 <strong>Key Features of Rive:</strong>  
- 🎞️ Real-time animation rendering  
- ⚙️ Built-in state machine system for logic-based motion  
- 💡 Lightweight and cross-platform integration  
- 🧠 Ideal for creating interactive UI components and animated mascots  

---

<h2 align="center">⚙️ What is a <span style="color:#9c27b0;">State Machine</span>?</h2>

<p align="center">
  <em>
    A State Machine is a behavioral model that describes how a system transitions between different states 
    in response to user actions or events.
  </em>
</p>

---

A <strong>State Machine</strong> can only be in <strong>one state at a time</strong> and has a 
<strong>finite number of possible states</strong>, such as <em>idle</em>, <em>checking</em>, <em>success</em>, or <em>error</em>.

In <strong>Rive</strong>, it defines <strong>how animations change between states</strong> — 
allowing the character to react dynamically to user input.

---

<h4 align="center">🔁 Example Flow</h4>

<p align="center">
  <code style="font-size: 1.1em;">idle → checking → success → fail</code>
</p>

---

### 🧩 Inputs Used in Rive’s State Machine

Each input type helps control animation behavior and transitions:

🔘 <strong>SMIBool</strong> → Boolean values (e.g., <code>isChecking</code>, <code>isHandsUp</code>)  
🔢 <strong>SMINumber</strong> → Numeric values (e.g., <code>numLook</code>)  
🚀 <strong>SMITrigger</strong> → Event triggers (e.g., <code>trigSuccess</code>, <code>trigFail</code>)  

These inputs make animations <strong>interactive, dynamic, and realistic</strong>, reacting instantly to user behavior.

---

<h2 align="center">💻 Technologies Used</h2>

<p align="center">
  <em>
    This project combines several tools and libraries to create a smooth, responsive, and interactive user experience.
  </em>
</p>

---

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white"/>
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white"/>
  <img src="https://img.shields.io/badge/Rive-FF6F00?style=for-the-badge&logo=rive&logoColor=white"/>
  <img src="https://img.shields.io/badge/Material%20Design-757575?style=for-the-badge&logo=material-design&logoColor=white"/>
</p>

---

| 🧩 **Technology** | 🧠 **Purpose / Description** |
|:------------------|:-----------------------------|
| 🐦 **Flutter (Dart SDK)** | Framework used to build the app’s interface and core logic. |
| 🎨 **Rive Animation Engine** | Enables real-time interactive animations within Flutter. |
| ⚙️ **State Machine Controller** | Manages transitions and reactions of the animated character based on user input. |
| 🧱 **Material Design Widgets** | Provides reusable and responsive UI components for a modern, consistent look. |

---

<p align="center">
  <em>✨ Built with modern Flutter tools to deliver smooth animation and responsive interaction.</em>
</p>

---

<h2 align="center">📂 Project Structure</h2>

<p align="center">
  <em>
    The <strong>lib/</strong> folder contains the core files of the project, organized to keep the code clean, modular, and easy to maintain.
  </em>
</p>

---

    📁 lib/
    ├── 🏠 main.dart → Main entry point of the application
    ├── 📁 screen/
    │ └── 🔑 login_screen.dart → Login screen with Rive animation and state controller logic
    ├── 📁 assets/
    │ └── 🎭 animated_login_character.riv → Rive animation file
    └── ⚙️ widgets/ → Reusable interface components (buttons, text fields, etc.)

---

<p align="center">
  <em>
    🧠 This structure ensures modularity, reusability, and seamless integration between Flutter and Rive.
  </em>
</p>

---

<h2 align="center">🎬 Project Demo</h2>

<p align="center">
  <em>
    The animated character reacts in real time as you type your email, covers its eyes while entering the password,
    and shows success or error animations based on login results.
  </em>
</p>

---

<p align="center">
  <em>👇 Watch the full login animation in action 👇</em>
</p>

<p align="center">
  <img src="assets/Animación.gif" alt="Login Animation Demo" width="480" style="border-radius:10px;"/>
</p>

---

<h2 align="center">📘 Academic Information</h2>

---

<p align="center">
  <table>
    <tr><td>📚 <strong>Course:</strong></td><td>Computer Graphics</td></tr>
    <tr><td>👨‍🏫 <strong>Instructor:</strong></td><td>Rodrigo Fidel Gaxiola Sosa</td></tr>
    <tr><td>🧑‍💻 <strong>Student:</strong></td><td>Luis Angel Santamaria Aguayo</td></tr>
    <tr><td>🏫 <strong>Institution:</strong></td><td>Instituto Tecnológico de Mérida</td></tr>
  </table>
</p>

---

<p align="center">
  <em>🎓 Developed as part of the Computer Graphics course at the Instituto Tecnológico de Mérida.</em>
</p>

---

<h2 align="center">🙌 Credits</h2>

---

<p align="center">
  🧸 <strong>Original Animation:</strong> 
  <a href="https://rive.app/marketplace/3645-7621-remix-of-login-machine/" target="_blank">
    Remix of Login Machine – Rive
  </a>
  <br><br>
  💻 <strong>Project Developed For:</strong> Computer Graphics Course, Instituto Tecnológico de Mérida
</p>

---

<p align="center">
  <em>✨ Made with ❤️ using Flutter and Rive ✨</em>
</p>
