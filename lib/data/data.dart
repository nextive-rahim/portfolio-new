import '../models/resume_data.dart';

const resumeData = ResumeData(
  name: "Abdul Rahim",
  title: "Senior Flutter Developer & Team Lead",
  location: "Dhaka, Bangladesh",
  email: "rahimsr983@gmail.com",
  phone: "01718663032",
  linkedin: "linkedin.com/in/abdul-rahim-6b09292a0",
  github: "github.com/developer-rahim",
  summary:
      "Experienced Senior Flutter developer with 4+ years of mobile expertise and 1+ year backend experience in Node.js/NestJS. Proven leader of cross-functional teams at Nextive Solution, delivering 40+ production apps across Android and iOS. Expert in offline-first systems, custom UI/UX, and high-performance architectures.",
  coreSkills: [
    SkillCategory(
      title: "Mobile (Flutter/Dart)",
      skills: [
        "Cross-platform (iOS/Android)",
        "State Management (GetX, Bloc, Riverpod)",
        "Offline-First Architectures",
        "Custom Animations",
        "Payment Gateways",
        "Push Notifications"
      ],
    ),
    SkillCategory(
      title: "Backend & Systems",
      skills: [
        "Node.js",
        "NestJS",
        "Express.js",
        "REST & GraphQL",
        "MongoDB",
        "PostgreSQL",
        "Firebase Cloud Functions",
        "JWT Auth"
      ],
    ),
    SkillCategory(
      title: "Optimization",
      skills: [
        "Advanced Caching (Hive)",
        "Memory Management",
        "Image Compression",
        "Lazy Loading",
        "CI/CD Pipelines",
        "App Store/Play Store DevOps"
      ],
    ),
  ],
  experience: [
    Experience(
      company: "Nextive Solution, Kawran Bazar, Dhaka",
      location: "Dhaka, Bangladesh",
      role: "Team Lead – Flutter & Backend",
      period: "2023 – Present",
      bullets: [
        "Led a team of Flutter & backend developers, managing development lifecycle end-to-end",
        "Designed and implemented scalable mobile architectures using Flutter + Node.js/NestJS",
        "Conducted code review sessions and enforced clean coding practices",
        "Built high-performing apps using offline-first architecture and advanced caching",
        "Integrated complex APIs, including payment systems and background services",
        "Managed Play Store & App Store submission processes",
        "Implemented CI/CD deployment pipelines for smoother updates"
      ],
    ),
    Experience(
      company: "Excel IT, Moghbazar, Dhaka",
      location: "Dhaka, Bangladesh",
      role: "Mid-Level Flutter Developer",
      period: "2021 – 2022",
      bullets: [
        "Developed production-level Flutter apps for both Android and iOS",
        "Integrated REST APIs, Firebase, WebSockets, and local storage solutions",
        "Implemented offline syncing, background fetching, and advanced caching layers",
        "Optimized app load times, improving performance by 40–60% across major features",
        "Created reusable components, custom widgets, and animation-based user interfaces"
      ],
    ),
    Experience(
      company: "Large IT, Mohammadpur, Dhaka",
      location: "Dhaka, Bangladesh",
      role: "Junior Flutter Developer",
      period: "2020 – 2021",
      bullets: [
        "Worked on UI screen development and pixel-perfect designs",
        "Wrote efficient Dart code and contributed to core features",
        "Implemented Firebase Auth, Cloud Messaging, and Firestore logic",
        "Improved app performance by reducing unnecessary rebuilds",
        "Assisted in version control & deployment tasks"
      ],
    ),
  ],
  education: Education(
    degree: "B.Sc in Computer Science & Engineering",
    institution: "Model Institution of Science and Technology (MIST)",
    completed: "2021",
    major: "Computer Science",
  ),
  majorProjects: [
    Project(
      name: "BCS Doctor",
      link:
          "https://play.google.com/store/apps/details?id=com.nextive.bcsdoctor&hl=en",
      description:
          "Comprehensive exam prep tool with massive offline caching capabilities.",
      features: ["Offline Mode", "Auto-Sync", "Caching Architecture"],
    ),
    Project(
      name: "Physics Study BD",
      link:
          "https://play.google.com/store/apps/details?id=com.nextive.physicsstudy.bd&hl=en",
      description:
          "Premium education platform with advanced UI animations and exam modules.",
      features: ["Lottie Animations", "Real-time Exams", "Custom Rendering"],
    ),
    Project(
      name: "SMS to Mail",
      description:
          "Enterprise utility app forwarding device SMS to SMTP email in background.",
      features: ["Battery Optimized", "Background Worker", "Secure Auth"],
    ),
    Project(
      name: "Bongo Baba",
      link: "https://bongobaba.en.softonic.com/android",
      description:
          "Full-scale E-commerce application with diverse payment gateway integrations.",
      features: ["Payment Logic", "Order Tracking", "Dynamic Catalog"],
    ),
  ],
  appLinks: [
    AppLink(
        name: "BCS Doctor",
        platform: AppPlatform.playStore,
        url:
            "https://play.google.com/store/apps/details?id=com.nextive.bcsdoctor"),
    AppLink(
        name: "Physics Study BD",
        platform: AppPlatform.playStore,
        url:
            "https://play.google.com/store/apps/details?id=com.nextive.physicsstudy.bd"),
    AppLink(
        name: "Science Platform",
        platform: AppPlatform.appStore,
        url: "https://apps.apple.com/us/app/science-platform/id6748245666"),
    AppLink(
        name: "Karigori Pathsala",
        platform: AppPlatform.appStore,
        url: "https://apps.apple.com/us/app/karigori-pathsala/id6754215048"),
    AppLink(
        name: "Shikkha Squared",
        platform: AppPlatform.appStore,
        url: "https://apps.apple.com/us/app/shikkha-squared/id6751794182"),
    AppLink(
        name: "eTestPaper",
        platform: AppPlatform.appStore,
        url: "https://apps.apple.com/us/app/etestpaper/id6749287735"),
    AppLink(
        name: "Master Class",
        platform: AppPlatform.appStore,
        url: "https://apps.apple.com/us/app/master-class-bank-job/id6753141252"),
    AppLink(
        name: "Nayeem's English Care",
        platform: AppPlatform.appStore,
        url: "https://apps.apple.com/us/app/nayeems-english-care/id6748595972"),
    AppLink(
        name: "Board Books",
        platform: AppPlatform.appStore,
        url: "https://apps.apple.com/us/app/board-books/id6751452947"),
    AppLink(
        name: "Admission Assistant",
        platform: AppPlatform.appStore,
        url: "https://apps.apple.com/us/app/admission-assistant/id6749927738"),
    AppLink(
        name: "Bongo Baba",
        platform: AppPlatform.softonic,
        url: "https://bongobaba.en.softonic.com/android"),
  ],
  strengths: [
    "Expert Team Leadership",
    "Clean Architecture Focused",
    "Performance Optimization Obsessed",
    "Scalable Backend Design",
    "Rapid Problem Solving"
  ],
);
