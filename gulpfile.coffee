gulp = require 'gulp'
del = require 'del'
fs = require 'fs'
run = require 'run-sequence'
shell = require 'gulp-shell'
argv = process.argv
recursive = require 'recursive-readdir'

dir = {}
dir.old = '_old'
dir.new = '_new'
dir.out = '_out'

gm = {}
# 処理結果の解像度。上げすぎると処理が遅くなり、下げすぎると文字が読めない
gm.compareStyle = 'tint'

# 分割された画像を順番に比較し、比較結果を出力してPNGにまとめる
gulp.task 'compare', ->

  gulp.src ".", ->
    recursive "#{dir.old}", [".DS_Store"], (err, files) ->
      commands = []
      for tmp in files
#        if tmp.match /\/\.png$/gi

        # パスの頭の_old/を削除
        path = tmp.replace /^_old\//gi, ''
        console.log "gm compare -highlight-style #{gm.compareStyle} -file #{dir.out}/#{path} #{dir.old}/#{path} #{dir.new}/#{path}"
        commands.push "gm compare -highlight-style #{gm.compareStyle} -hilight-color red -file #{dir.out}/#{path} #{dir.old}/#{path} #{dir.new}/#{path}\n"

      # console.log commands

      # コマンド実行
      gulp.src '.'
        # ディレクトリ作成
        .pipe shell [
          "mkdir -p #{dir.out}/case/details"
          "mkdir -p #{dir.out}/service/details"
          "mkdir -p #{dir.out}/doc"
        ]
        .pipe shell(commands)


# 一時ファイルのクリーン
gulp.task 'clean', (cb) ->
  del [
    "_*.png"
    "./#{dir.out}"
  ], ->
    gulp.src '.'
    .pipe shell ["mkdir #{dir.out}\n"]
    .on 'end', ->
      cb()

# ソースを含めて削除する
gulp.task 'cleanDeep', (cb) ->
  del [
    "#{dir.new}"
    "#{dir.old}"
    "#{dir.out}"
  ], ->
    gulp.src '.'
    # .pipe shell ["mkdir #{dir.old}\nmkdir #{dir.new}\n"]
    .on 'end', ->
      cb()

# 実行
gulp.task 'default', ->
  run 'clean', 'compare'