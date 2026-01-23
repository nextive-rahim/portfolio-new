class Experience {
  final String company;
  final String location;
  final String role;
  final String period;
  final List<String> bullets;

  const Experience({
    required this.company,
    required this.location,
    required this.role,
    required this.period,
    required this.bullets,
  });
}

class Project {
  final String name;
  final String description;
  final List<String> features;
  final String? link;

  const Project({
    required this.name,
    required this.description,
    required this.features,
    this.link,
  });
}

enum AppPlatform { playStore, appStore, softonic }

class AppLink {
  final String name;
  final AppPlatform platform;
  final String url;

  const AppLink({
    required this.name,
    required this.platform,
    required this.url,
  });
}

class SkillCategory {
  final String title;
  final List<String> skills;

  const SkillCategory({
    required this.title,
    required this.skills,
  });
}

class Education {
  final String degree;
  final String institution;
  final String completed;
  final String major;

  const Education({
    required this.degree,
    required this.institution,
    required this.completed,
    required this.major,
  });
}

class ResumeData {
  final String name;
  final String title;
  final String location;
  final String email;
  final String phone;
  final String linkedin;
  final String github;
  final String summary;
  final List<SkillCategory> coreSkills;
  final List<Experience> experience;
  final Education education;
  final List<Project> majorProjects;
  final List<AppLink> appLinks;
  final List<String> strengths;

  const ResumeData({
    required this.name,
    required this.title,
    required this.location,
    required this.email,
    required this.phone,
    required this.linkedin,
    required this.github,
    required this.summary,
    required this.coreSkills,
    required this.experience,
    required this.education,
    required this.majorProjects,
    required this.appLinks,
    required this.strengths,
  });
}
