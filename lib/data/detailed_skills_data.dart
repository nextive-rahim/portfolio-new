import '../models/detailed_skill.dart';
import 'skill_strings.dart';

/// All detailed skill categories for the portfolio
const List<DetailedSkillCategory> detailedSkillCategories = [
  // 1. Framework and Programming
  DetailedSkillCategory(
    categoryTitle: SkillStrings.frameworkAndProgramming,
    skills: [
      DetailedSkill(
        title: SkillStrings.flutterFramework,
        description: SkillStrings.flutterFrameworkDescription,
      ),
      DetailedSkill(
        title: SkillStrings.dartProgramming,
        description: SkillStrings.dartProgrammingDescription,
      ),
    ],
  ),

  // 2. State Management
  DetailedSkillCategory(
    categoryTitle: SkillStrings.stateManagement,
    skills: [
      DetailedSkill(
        title: SkillStrings.provider,
        description: SkillStrings.providerDescription,
      ),
      DetailedSkill(
        title: SkillStrings.riverpod,
        description: SkillStrings.riverpodDescription,
      ),
      DetailedSkill(
        title: SkillStrings.getX,
        description: SkillStrings.getXDescription,
      ),
    ],
  ),

  // 3. Backend and API Integration
  DetailedSkillCategory(
    categoryTitle: SkillStrings.backendAndAPIIntegration,
    skills: [
      DetailedSkill(
        title: SkillStrings.restfulApis,
        description: SkillStrings.restfulApisDescription,
      ),
      DetailedSkill(
        title: SkillStrings.firebase,
        description: SkillStrings.firebaseDescription,
      ),
    ],
  ),

  // 4. Local Database
  DetailedSkillCategory(
    categoryTitle: SkillStrings.localDatabase,
    skills: [
      DetailedSkill(
        title: SkillStrings.hive,
        description: SkillStrings.hiveDescription,
      ),
      DetailedSkill(
        title: SkillStrings.sqfLite,
        description: SkillStrings.sqfLiteDescription,
      ),
      DetailedSkill(
        title: SkillStrings.sharedPreferences,
        description: SkillStrings.sharedPreferencesDescription,
      ),
      DetailedSkill(
        title: SkillStrings.getStorage,
        description: SkillStrings.getStorageDescription,
      ),
    ],
  ),

  // 5. Performance Optimization
  DetailedSkillCategory(
    categoryTitle: SkillStrings.performanceOptimization,
    skills: [
      DetailedSkill(
        title: SkillStrings.devTools,
        description: SkillStrings.devToolsDescription,
      ),
      DetailedSkill(
        title: SkillStrings.performance,
        description: SkillStrings.performanceDescription,
      ),
    ],
  ),

  // 6. DevOps and Deployment
  DetailedSkillCategory(
    categoryTitle: SkillStrings.devOpsAndDeployment,
    skills: [
      DetailedSkill(
        title: SkillStrings.appStorePlayStore,
        description: SkillStrings.appStorePlayStoreDescription,
      ),
      DetailedSkill(
        title: SkillStrings.ciCdPipelines,
        description: SkillStrings.ciCdPipelinesDescription,
      ),
    ],
  ),

  // 7. Tools and Version Control
  DetailedSkillCategory(
    categoryTitle: SkillStrings.toolsAndVersionControl,
    skills: [
      DetailedSkill(
        title: SkillStrings.ideTools,
        description: SkillStrings.ideToolsDescription,
      ),
      DetailedSkill(
        title: SkillStrings.versionControl,
        description: SkillStrings.versionControlDescription,
      ),
      DetailedSkill(
        title: SkillStrings.packageManagement,
        description: SkillStrings.packageManagementDescription,
      ),
    ],
  ),

  // 8. Other Relevant Skills
  DetailedSkillCategory(
    categoryTitle: SkillStrings.otherRelevantSkills,
    skills: [
      DetailedSkill(
        title: SkillStrings.pushNotifications,
        description: SkillStrings.pushNotificationsDescription,
      ),
      DetailedSkill(
        title: SkillStrings.paymentGateway,
        description: SkillStrings.paymentGatewayDescription,
      ),
      DetailedSkill(
        title: SkillStrings.offlineService,
        description: SkillStrings.offlineServiceDescription,
      ),
      DetailedSkill(
        title: SkillStrings.chatGptIntegration,
        description: SkillStrings.chatGptIntegrationDescription,
      ),
      DetailedSkill(
        title: SkillStrings.platformSpecificApp,
        description: SkillStrings.platformSpecificAppDescription,
      ),
    ],
  ),
];
