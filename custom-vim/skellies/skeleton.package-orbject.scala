package `!v join(split(GetPackageForFile(), '\.')[:-2], ".")`

package object `!v split(GetPackageForFile(), '\.')[-1]` {
  $1
}
