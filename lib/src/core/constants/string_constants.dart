class M7StringConstants {
  final M7LabelStrings label;
  final M7ButtonStrings button;
  final bool isNoteVisible;

  const M7StringConstants({
    this.label = const M7LabelStrings(),
    this.button = const M7ButtonStrings(),
    this.isNoteVisible = false,
  });

  // /// Default instance (optional convenience)
  // static const M7StringConstants defaultValues = M7StringConstants();
}

class M7LabelStrings {
  final String livelyNessDetection;
  final String goodLighting;
  final String lookStraight;
  final String goodLightingSubText;
  final String lookStraightSubText;
  final String infoSubText;
  final String noteText;

  const M7LabelStrings({
    this.livelyNessDetection = "Face Match 2.0",
    this.goodLighting = "Good Lighting",
    this.lookStraight = "Look Straight",
    this.goodLightingSubText =
        "सुनिश्चित करें कि आप अच्छी रोशनी वाले क्षेत्र में हों और दोनों कान खुले हों",
    this.lookStraightSubText =
        "अपने फोन को आंखों के स्तर पर रखें और सीधे कैमरे की ओर देखें",
    this.infoSubText =
        "हम इस सेल्फी का उपयोग अगले चरण में अनिवार्य फ़ोटो के साथ तुलना करने के लिए करते हैं",
    this.noteText =
        "सुनिश्चित करें कि आप अच्छी रोशनी वाले क्षेत्र में हों और दोनों कान खुले हों अपने फोन को आंखों के स्तर पर रखें और सीधे कैमरे की ओर देखें",
  });
}

class M7ButtonStrings {
  final String start;

  const M7ButtonStrings({
    this.start = "Start",
  });
}
