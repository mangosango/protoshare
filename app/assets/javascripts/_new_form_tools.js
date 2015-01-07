var $tags = $('#tags');
var $parent = $('#tags_tagsinput');
$tags.tagsInput({
  'height':'auto',
  'width':'100%',
  'interactive':true,
  'defaultText':'Add, some, tags',
  'minChars' : 0,
  'maxChars' : 150,
  'placeholderColor' : '#9D9FA2'
});