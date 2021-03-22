extends Control

var DNAString := ""
var codingString := ""
var noncodingString := ""
#func _ready() -> void:
#	$Popup.popup_centered(Vector2(300,200))
#	$Popup/WindowDialog.popup_centered(Vector2(300,200))


func _on_Popup_about_to_show() -> void:
	print("yes")


func _on_WindowDialog_file_selected(path: String) -> void:
	print(path)
	var f := File.new()
	f.open(path, File.READ)
	DNAString = f.get_as_text()
	f.close()
	$Popup.queue_free()


func _on_LineEdit_text_changed(new_text: String) -> void:
	DNAString = new_text
	codingString = ""
	noncodingString = ""
	for v in $VBoxContainer/ScrollContainer/VBoxContainer.get_children():
		for vv in v.get_children():
			vv.queue_free()
	DNAThing()



func DNAThing() -> void:
	for letter in DNAString:
		var DNAbase := preload("res://src/DNAbase.tscn").instance()
		var cDNAbase := preload("res://src/DNAbase.tscn").instance()
		DNAbase.get_node("Label").text = letter
		match letter:
			"A":
				DNAbase.get_node("ColorRect").color = Color.coral
			"T":
				DNAbase.get_node("ColorRect").color = Color.darkkhaki
			"G":
				DNAbase.get_node("ColorRect").color = Color.seagreen
			"C":
				DNAbase.get_node("ColorRect").color = Color.teal
			
		$VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer.add_child(DNAbase)
		var tempLetter : String
		match letter:
			"A":
				tempLetter = "T"
			"T":
				tempLetter = "A"
			"G":
				tempLetter = "C"
			"C":
				tempLetter = "G"
		cDNAbase.get_node("Label").text = tempLetter
		match tempLetter:
			"A":
				cDNAbase.get_node("ColorRect").color = Color.coral
			"T":
				cDNAbase.get_node("ColorRect").color = Color.darkkhaki
			"G":
				cDNAbase.get_node("ColorRect").color = Color.seagreen
			"C":
				cDNAbase.get_node("ColorRect").color = Color.teal
		$VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer4.add_child(cDNAbase)


	for letter in DNAString:
		var DNAbase := preload("res://src/DNAbase.tscn").instance()
		var CDNAbase := preload("res://src/DNAbase.tscn").instance()
		var tempLetter : String
		var nclr : String
		match letter:
			"A":
				nclr = "A"
				tempLetter = "U"
			"T":
				nclr = "U"
				tempLetter = "A"
			"G":
				nclr = "G"
				tempLetter = "C"
			"C":
				nclr = "C"
				tempLetter = "G"
		codingString += tempLetter
		noncodingString += nclr
		DNAbase.get_node("Label").text = tempLetter
		CDNAbase.get_node("Label").text = nclr
		match tempLetter:
			"A":
				DNAbase.get_node("ColorRect").color = Color.coral
				CDNAbase.get_node("ColorRect").color = Color.lightpink
			"U":
				CDNAbase.get_node("ColorRect").color = Color.coral
				DNAbase.get_node("ColorRect").color = Color.lightpink
			"G":
				CDNAbase.get_node("ColorRect").color = Color.teal
				DNAbase.get_node("ColorRect").color = Color.seagreen
			"C":
				CDNAbase.get_node("ColorRect").color = Color.seagreen
				DNAbase.get_node("ColorRect").color = Color.teal
		$VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer5.add_child(DNAbase)
		$VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer6.add_child(CDNAbase)

	for i in codingString.length():
		var ti :int= i+1
		if ti % 3 == 0:
			var aa := preload("res://src/AAbase.tscn").instance()
			aa.rect_min_size.x = 120
			var aaChosen : String
			var codon := codingString[i-2]+codingString[i-1]+codingString[i]
			var ret := codon_return_aa(codon)
#			print(codon + " i CODON")
			aa.get_node("ColorRect").color = ret[1]
			aa.get_node("Label").text = ret[0]
			$VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer7.add_child(aa)

	for i in codingString.length():
		var ti :int= i+1
		if ti % 3 == 0:
			var aa := preload("res://src/AAbase.tscn").instance()
			aa.rect_min_size.x = 120
			var aaChosen : String
			var codon := noncodingString[i-2]+noncodingString[i-1]+noncodingString[i]
			var ret := codon_return_aa(codon)
#			print(codon + " i CODON")
			aa.get_node("ColorRect").color = ret[1]
			aa.get_node("Label").text = ret[0]
			$VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer8.add_child(aa)

func codon_return_aa(codon:String) -> Array:
	var s := "NO MATCH"
	var col : Color
	match codon:
		"UUU":
			s = "Phe"
			col = Color.yellowgreen
		"UUC":
			col = Color.yellowgreen
			s = "Phe"
		"UUA":
			col = Color.blue
			s = "Leu"
		"UUG":
			col = Color.blue
			s = "Leu"
		"CUU":
			col = Color.blue
			s = "Leu"
		"CUC":
			col = Color.blue
			s = "Leu"
		"CUA":
			col = Color.blue
			s = "Leu"
		"CUG":
			col = Color.blue
			s = "Leu"
		"AUU":
			col = Color.red
			s = "Ile"
		"AUC":
			col = Color.red
			s = "Ile"
		"AUA":
			col = Color.red
			s = "Ile"
		"AUG":
			s = "Met"
			
		"GUG":
			col = Color.brown
			s = "Val"
		"GUG":
			col = Color.brown
			s = "Val"
		"GUG":
			col = Color.brown
			s = "Val"
		"GCU":
			col = Color.brown
			s = "Val"
			
		"UCC":
			col = Color.darkblue
			s = "Ser"
		"UCA":
			col = Color.darkblue
			s = "Ser"
		"UCG":
			col = Color.darkblue
			s = "Ser"
		"UCU":
			s = "Ser"
			col = Color.darkblue
			
		"CCU":
			s = "Pro"
			col = Color.darkred
		"CCC":
			col = Color.darkred
			s = "Pro"
		"CCA":
			col = Color.darkred
			s = "Pro"
		"CCG":
			col = Color.darkred
			s = "Pro"
			
		"ACC":
			col = Color.darkgoldenrod
			s = "Thr"
		"ACA":
			col = Color.darkgoldenrod
			s = "Thr"
		"ACG":
			col = Color.darkgoldenrod
			s = "Thr"
		"ACU":
			col = Color.darkgoldenrod
			s = "Thr"
			
		"GCU":
			col = Color.darkturquoise
			s = "Ala"
		"GCC":
			col = Color.darkturquoise
			s = "Ala"
		"GCA":
			s = "Ala"
			col = Color.darkturquoise
		"GCG":
			s = "Ala"
			col = Color.darkturquoise
		
		"UAU":
			s = "Tyr"
			col = Color.darkslategray
		"UAC":
			col = Color.darkslategray
			s = "Tyr"
		"UAA":
			s = "Stop"
		"UAG":
			s = "Stop"
		
		"CAU":
			s = "His"
			col = Color.darkseagreen
		"CAC":
			s = "His"
			col = Color.darkseagreen
		"CAA":
			s = "Gln"
			col = Color.darkolivegreen
		"CAG":
			col = Color.darkolivegreen
			s = "Gln"
		
		"AAU":
			col = Color.darkkhaki
			s = "Asn"
		"AAC":
			col = Color.darkkhaki
			s = "Asn"
		"AAA":
			col = Color.darksalmon
			s = "Lys"
		"AAG":
			col = Color.darksalmon
			s = "Lys"
		
		"GAU":
			col = Color.webmaroon
			s = "Asp"
		"GAC":
			col = Color.webmaroon
			s = "Asp"
		"GAA":
			col = Color.gainsboro
			s = "Glu"
		"GAG":
			col = Color.gainsboro
			s = "Glu"


		
		"UGU":
			col = Color.green
			s = "Cys"
		"UGC":
			col = Color.green
			s = "Cys"
		"UGA":
			s = "Stop"
		"UGG":
			s = "Trp"
			col = Color.yellow
			
		
		"CGU":
			col = Color.darkgreen
			s = "Arg"
		"CGC":
			col = Color.darkgreen
			s = "Arg"
		"CGA":
			col = Color.darkgreen
			s = "Arg"
		"CGG":
			col = Color.darkgreen
			s = "Arg"
		
		"AGU":
			col = Color.silver
			s = "Ser"
		"AGC":
			col = Color.silver
			s = "Ser"
		"AGA":
			col = Color.darkgreen
			s = "Arg"
		"AGG":
			col = Color.darkgreen
			s = "Arg"
		
		"GGU":
			col = Color.darkorchid
			s = "Gly"
		"GGC":
			col = Color.darkorchid
			s = "Gly"
		"GGA":
			col = Color.darkorchid
			s = "Gly"
		"GGG":
			col = Color.darkorchid
			s = "Gly"
	return [s,col]

