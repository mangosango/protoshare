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
// Variable to store your files
var files;

// Add events
$('input[type=file]').on('change', prepareUpload);

// Grab the files and set them to our variable
function prepareUpload(event)
{
  files = event.target.files;
}