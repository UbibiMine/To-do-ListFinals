class TaskManager {
  static Map<String, List<String>> categories = {
    'Default': [],
  };

  static void addTask(String category, String task) {
    if (categories.containsKey(category)) {
      categories[category]!.add(task);
    }
  }

  static void addCategory(String category) {
    if (!categories.containsKey(category)) {
      categories[category] = [];
    }
  }

  static void deleteCategory(String category) {
    categories.remove(category);
  }

  static void moveTaskToDone(String category, String task) {
    if (categories.containsKey(category)) {
      categories[category]!.remove(task); // Remove from the current category
      if (!categories.containsKey('Done')) {
        categories['Done'] = []; // Ensure "Done" category exists
      }
      categories['Done']!.add(task); // Add to the "Done" category
    }
  }

  static void deleteTask(String category, String task) {
    categories[category]?.remove(task);
  }
}
