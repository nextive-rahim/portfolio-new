/// Model for a single skill with title and description
class DetailedSkill {
  final String title;
  final String description;

  const DetailedSkill({
    required this.title,
    required this.description,
  });
}

/// Model for a skill category containing multiple skills
class DetailedSkillCategory {
  final String categoryTitle;
  final List<DetailedSkill> skills;

  const DetailedSkillCategory({
    required this.categoryTitle,
    required this.skills,
  });
}
