function GoogleTranslateElementInit() {
  new google.translate.TranslateElement(
    {
      pageLanguage: 'ja',
      includedLanguages: 'en,ja,fr,es,de,zh-CN,zh-TW,ko,ar,ru,pt,vi,th,ms,id,uk,tl,sw,sv,pl,nl,it,hi,he,el,da,cs,fi,hu,no,ro' 
    },
    "google_translate_element"
  );
}
