<?pas

Program IFSTest;
var
  e: variant;
Begin
  e := null;
  case VarType(e) of
	varempty :writeln('unassigned');
	varNull: Writeln('null');
	varstring: Writeln('String');
	varInteger : writeln('VarInteger');
	varSingle: Writeln('Single');
	varDouble: Writeln('Double');
  end;
End.

?>