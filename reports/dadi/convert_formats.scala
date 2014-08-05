/* This Scala script takes a table-file with at least these columns:

```
position  ref  anc  major  minor  EG01  WG01  EG02 ...
945       A    A    A      G      GG     GG    AG  ...
```

Where `major` and `minor` are alleles, `WG` and `EG` are populations (and columns correspond to individuals)

Then you run it with

```
scala convert_formats.scala table_file.txt polar WG EG
```

`polar` - is just some label; list of the populations is mandatory.

You can redirect the output with

```
scala convert_formats.scala table_file.txt polar WG EG > out_file.snp
```

and then `out_file.snp` is ready for using in ∂a∂i.

*/

import java.io._
import java.nio.file.Path
import java.nio.file.Path._
import scala.io.Source

args.toList match {
  // expected args:
  case filename :: tpe :: populations => {

    val lines: Iterator[String] = Source.fromFile(filename, "UTF-8").getLines 
    if (!lines.hasNext) { sys.error("no table header") }

    val header = lines.next.split("""\t\s*\t*""")

    // writing header
    println((
      List("ref", "anc") ++
      ("Allele1" :: populations) ++
      ("Allele2" :: populations) ++ 
      List("type", "position")
    ).mkString("\t"))

    for(line <- lines) {

      val row = (header, line.split("\\s+")).zipped.map(_ -> _).toMap
      val allele1 = row("major")
      val allele2 = row("minor")

      def count(pop: String, allele: String): Int = row.map { 
        case (k, v) => if(k startsWith pop) v.count(_ == allele.head) else 0
      }.sum

      val allele1Numbers = populations map { count(_, allele1) }
      val allele2Numbers = populations map { count(_, allele2) }

      println(List(
        s"""-${row("ref")}-""",
        s"""-${row("anc")}-""",
        s"""${allele1}""",
        allele1Numbers.mkString("\t"),
        s"""${allele2}""",
        allele2Numbers.mkString("\t"),
        tpe,
        s"""${row("position")}"""
      ).mkString("\t"))

    }

  }
  case _ => sys.error("Wrong args! Required: filename, animal type, populations list")
}
