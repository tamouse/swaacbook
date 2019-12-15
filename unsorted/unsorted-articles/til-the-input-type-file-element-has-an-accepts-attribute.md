# TIL: The input\[type=file\] element has an accepts attribute

## TIL: The `input[type=file]` element has an `accepts` attribute

* Time-stamp: &lt;2018-11-20 00:30:53 tamara&gt;
* capture date: \[2018-11-20 Tue\]
* keywords: html, input, file, pass list

The `input[type=file]` element has an attribute, `accepts` that provides a pass filter for the types of files that are accepted in the input file field. See [the MDN documentation for input accept](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/file#accept) for details.

This means, if I have a set of allowed extensions, I can put them in the `accepts` field to limit what the user can select:

```text
<!-- to accept all image types -->
<input type="file" name="image_file" accept="image/*">

<!-- to accept various file extensions -->
<input type="file" name="data" accept=".jpg,.jpeg,.gif,.png,.bmp,.pdf,.txt,.md,.markdown">
```

With a little more work, if there is a pass list of extensions on the server, I could pass it down to the client via the `gon` object where a React client could pick it up.

```text
module App
  module CONSTANTS
    UPLOAD_PASS_LIST = %w[
      jpg
      jpeg
      png
      gif
      bmp
      pdf
      text
      txt
      markdown
      md
      csv
      xls
      xlsx
      doc
      docx
    ].freeze
  end
end
```

```text
before_action :export_upload_pass_list

# ...

def export_upload_pass_list
  gon.push(upload_pass_list: App::CONSTANTS::UPLOAD_PASS_LIST)
end
```

```text
accepts_list = () => {
    return gon.upload_pass_list.map(ext => `.${ext}`).join(",")
}

render() {
    return (
        <input
          type="file"
          name="data"
          accepts={this.accepts_list()}
          onChange={this.fileChange}
        />
    )
}
```

