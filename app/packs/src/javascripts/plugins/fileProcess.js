export const FileListItem = (a) => {
  a = [].slice.call(Array.isArray(a) ? a : arguments)
  for (var c, b = (c = a.length), d = !0; b-- && d; ) d = a[b] instanceof File
  if (!d) throw new TypeError('expected argument to FileList is File or array of File objects')
  for (b = new ClipboardEvent('').clipboardData || new DataTransfer(); c--; ) b.items.add(a[c])
  return b.files
}

export const fileProcess = (files) => {
  return new Promise((resolve, reject) => {
    // 傳入 resolve 與 reject，表示資料成功與失敗
    var j, len1, file
    var convert_files = []
    for (j = 0, len1 = files.length; j < len1; j++) {
      file = files[j]
      if (file.type.indexOf('image') >= 0 && file.size > 1048576) {
        handleImageUpload(file)
          .then((blob) => {
            convert_files.push(new File([blob], blob.name))
            if (convert_files.length == len1) {
              resolve(convert_files)
            }
          })
          .catch((response) => {
            console.log(response)
          })
      } else {
        convert_files.push(file)
        if (convert_files.length == len1) {
          resolve(convert_files)
        }
      }
    }
  })
}

export const handleImageUpload = async (imageFile) => {
  console.log('originalFile instanceof Blob', imageFile instanceof Blob) // true
  console.log(`originalFile size ${imageFile.size / 1024 / 1024} MB`)

  const options = {
    maxSizeMB: 1,
    maxWidthOrHeight: 1920,
    useWebWorker: true
  }
  try {
    const compressedFile = await imageCompression(imageFile, options)
    console.log('compressedFile instanceof Blob', compressedFile instanceof Blob) // true
    console.log(`compressedFile size ${compressedFile.size / 1024 / 1024} MB`) // smaller than maxSizeMB
    return compressedFile
  } catch (error) {
    console.log(error)
    return error
  }
}
