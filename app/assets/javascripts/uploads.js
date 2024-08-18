document.addEventListener('DOMContentLoaded', function() {
  const dropZone = document.getElementById('drop-zone');
  const fileInput = document.getElementById('file-upload');
  const fileNameDisplay = document.getElementById('file-name');
  const submitButton = document.getElementById('submit-button');

  if (dropZone && fileInput && fileNameDisplay && submitButton) {
    const acceptedTypes = ['text/plain'];
    const maxFileSize = 5 * 1024 * 1024; // 5MB
    fileInput.accept = '.txt';

    ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
      dropZone.addEventListener(eventName, preventDefaults, false);
      document.body.addEventListener(eventName, preventDefaults, false);
    });

    ['dragenter', 'dragover'].forEach(eventName => {
      dropZone.addEventListener(eventName, highlight, false);
    });

    ['dragleave', 'drop'].forEach(eventName => {
      dropZone.addEventListener(eventName, unhighlight, false);
    });

    dropZone.addEventListener('drop', handleDrop, false);
    fileInput.addEventListener('change', handleFileInputChange);

    function preventDefaults(e) {
      e.preventDefault();
      e.stopPropagation();
    }

    function highlight() {
      dropZone.classList.add('bg-indigo-100');
    }

    function unhighlight() {
      dropZone.classList.remove('bg-indigo-100');
    }

    function handleDrop(e) {
      const dt = e.dataTransfer;
      const files = dt.files;
      if (validateFile(files[0])) {
        fileInput.files = files;
        handleFileInputChange();
      }
    }

    function handleFileInputChange() {
      if (fileInput.files.length > 0) {
        const file = fileInput.files[0];
        if (validateFile(file)) {
          fileNameDisplay.textContent = file.name;
          submitButton.disabled = false;
          submitButton.classList.remove('opacity-50', 'cursor-not-allowed');
          submitButton.classList.add('cursor-pointer');
        } else {
          fileInput.value = '';
          submitButton.disabled = true;
          submitButton.classList.add('opacity-50', 'cursor-not-allowed');
          submitButton.classList.remove('cursor-pointer');
        }
      } else {
        fileNameDisplay.textContent = 'No file chosen';
        submitButton.disabled = true;
        submitButton.classList.add('opacity-50', 'cursor-not-allowed');
        submitButton.classList.remove('cursor-pointer');
      }
    }

    function validateFile(file) {
      if (!file) return false;

      if (!acceptedTypes.includes(file.type)) {
        fileNameDisplay.textContent = 'Invalid file type. Please upload only TXT files.';
        return false;
      }

      if (file.size > maxFileSize) {
        fileNameDisplay.textContent = 'File is too large. Maximum size is 2MB.';
        return false;
      }
      return true;
    }

  } else {
    console.error('One or more elements not found');
  }
});
