class Languages {
  static String current_language = "EN";

  static final Map deutsch = {
    "menu.profile": "Profil",
    "menu.settings": "Einstellungen",
    "menu.feedback": "Feedback",
    "menu.lock": "Sperren",
    "menu.language": "Sprache ändern",
    "menu.logout": "Ausloggen",
    "chat.send": "Nachricht eingeben...",

  };
  static final Map english = {
    "menu.profile": "Profile",
    "menu.settings": "Settings",
    "menu.feedback": "Feedback",
    "menu.lock": "Lock",
    "menu.language": "Change Language",
    "menu.logout": "Logout",
    "chat.send": "Type message...",
  };

  static String getText(String key) {
    if (current_language == "EN") {
      return english[key];
    } else {
      return deutsch[key];
    }
  }

}