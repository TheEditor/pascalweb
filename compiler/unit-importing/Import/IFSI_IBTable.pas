unit IFSI_IBTable;
{
This file has been generated by UnitParser v0.4, written by M. Knight.
Source Code from Carlo Kok has been used to implement various sections of
UnitParser. Components of ifps3 are used in the construction of UnitParser,
code implementing the class wrapper is taken from Carlo Kok''s conv unility

}
{$I ifps3_def.inc}
interface
 
uses
   SysUtils
  ,Classes
  ,IFPS3CompExec
  ,ifpscomp
  ,ifps3
  ;
 
type 
(*----------------------------------------------------------------------------*)
  TIFPS3CE_IBTable = class(TIFPS3Plugin)
  protected
    procedure CompOnUses(CompExec: TIFPS3CompExec); override;
    procedure ExecOnUses(CompExec: TIFPS3CompExec); override;
    procedure CompileImport1(CompExec: TIFPS3CompExec); override;
    procedure CompileImport2(CompExec: TIFPS3CompExec); override;
    procedure ExecImport1(CompExec: TIFPS3CompExec; const ri: TIFPSRuntimeClassImporter); override;
    procedure ExecImport2(CompExec: TIFPS3CompExec; const ri: TIFPSRuntimeClassImporter); override;
  end;
 
 
(*
{ compile-time registration functions }
procedure SIRegister_TIBTABLE(CL: TIFPSPascalCompiler);
procedure SIRegister_IBTable(CL: TIFPSPascalCompiler);
 
{ run-time registration functions }
procedure RIRegister_TIBTABLE(CL: TIFPSRuntimeClassImporter);
procedure RIRegister_IBTable(CL: TIFPSRuntimeClassImporter);
*)


implementation


uses
   DB
  ,IB
  ,IBDATABASE
  ,IBCUSTOMDATASET
  ,IBHEADER
  ,IBSQL
  ,IBUTILS
  ,IBTable
  ;
 
 
{ compile-time importer function }
(*----------------------------------------------------------------------------
 Sometimes the CL.AddClassN() fails to correctly register a class, 
 for unknown (at least to me) reasons
 So, you may use the below RegClassS() replacing the CL.AddClassN()
 of the various SIRegister_XXXX calls 
 ----------------------------------------------------------------------------*)
function RegClassS(CL: TIFPSPascalCompiler; const InheritsFrom, Classname: string): TIFPSCompileTimeClass;
begin
  Result := CL.FindClass(Classname);
  if Result = nil then
    Result := CL.AddClassN(CL.FindClass(InheritsFrom), Classname)
  else Result.ClassInheritsFrom := CL.FindClass(InheritsFrom);
end;
  
  
(* === compile-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure SIRegister_TIBTABLE(CL: TIFPSPascalCompiler);
begin
  //with RegClassS(CL,'TIBCUSTOMDATASET', 'TIBTABLE') do
  with CL.AddClassN(CL.FindClass('TIBCUSTOMDATASET'),'TIBTABLE') do
  begin
    RegisterMethod('Procedure ADDINDEX( const NAME, FIELDS : STRING; OPTIONS : TINDEXOPTIONS; const DESCFIELDS : STRING)');
    RegisterMethod('Procedure CREATETABLE');
    RegisterMethod('Procedure DELETEINDEX( const NAME : STRING)');
    RegisterMethod('Procedure DELETETABLE');
    RegisterMethod('Procedure EMPTYTABLE');
    RegisterMethod('Procedure GETINDEXNAMES( LIST : TSTRINGS)');
    RegisterMethod('Procedure GOTOCURRENT( TABLE : TIBTABLE)');
    RegisterProperty('CURRENTDBKEY', 'TIBDBKEY', iptr);
    RegisterProperty('EXISTS', 'BOOLEAN', iptr);
    RegisterProperty('INDEXFIELDCOUNT', 'INTEGER', iptr);
    RegisterProperty('INDEXFIELDS', 'TFIELD INTEGER', iptrw);
    RegisterProperty('TABLENAMES', 'TSTRINGS', iptr);
    RegisterProperty('DEFAULTINDEX', 'BOOLEAN', iptrw);
    RegisterProperty('INDEXDEFS', 'TINDEXDEFS', iptrw);
    RegisterProperty('INDEXFIELDNAMES', 'STRING', iptrw);
    RegisterProperty('INDEXNAME', 'STRING', iptrw);
    RegisterProperty('MASTERFIELDS', 'STRING', iptrw);
    RegisterProperty('MASTERSOURCE', 'TDATASOURCE', iptrw);
    RegisterProperty('READONLY', 'BOOLEAN', iptrw);
    RegisterProperty('STOREDEFS', 'BOOLEAN', iptrw);
    RegisterProperty('TABLENAME', 'STRING', iptrw);
    RegisterProperty('TABLETYPES', 'TIBTABLETYPES', iptrw);
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_IBTable(CL: TIFPSPascalCompiler);
begin
  CL.AddTypeS('TIBTABLETYPE', '( TTSYSTEM, TTVIEW )');
  CL.AddTypeS('TIBTABLETYPES', 'set of TIBTABLETYPE');
  CL.AddTypeS('TINDEXNAME', 'STRING');
  CL.AddClassN(CL.FindClass('TOBJECT'),'TIBTABLE');
  SIRegister_TIBTABLE(CL);
end;

(* === run-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure TIBTABLETABLETYPES_W(Self: TIBTABLE; const T: TIBTABLETYPES);
begin Self.TABLETYPES := T; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLETABLETYPES_R(Self: TIBTABLE; var T: TIBTABLETYPES);
begin T := Self.TABLETYPES; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLETABLENAME_W(Self: TIBTABLE; const T: STRING);
begin Self.TABLENAME := T; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLETABLENAME_R(Self: TIBTABLE; var T: STRING);
begin T := Self.TABLENAME; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLESTOREDEFS_W(Self: TIBTABLE; const T: BOOLEAN);
begin Self.STOREDEFS := T; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLESTOREDEFS_R(Self: TIBTABLE; var T: BOOLEAN);
begin T := Self.STOREDEFS; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLEREADONLY_W(Self: TIBTABLE; const T: BOOLEAN);
begin Self.READONLY := T; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLEREADONLY_R(Self: TIBTABLE; var T: BOOLEAN);
begin T := Self.READONLY; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLEMASTERSOURCE_W(Self: TIBTABLE; const T: TDATASOURCE);
begin Self.MASTERSOURCE := T; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLEMASTERSOURCE_R(Self: TIBTABLE; var T: TDATASOURCE);
begin T := Self.MASTERSOURCE; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLEMASTERFIELDS_W(Self: TIBTABLE; const T: STRING);
begin Self.MASTERFIELDS := T; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLEMASTERFIELDS_R(Self: TIBTABLE; var T: STRING);
begin T := Self.MASTERFIELDS; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLEINDEXNAME_W(Self: TIBTABLE; const T: STRING);
begin Self.INDEXNAME := T; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLEINDEXNAME_R(Self: TIBTABLE; var T: STRING);
begin T := Self.INDEXNAME; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLEINDEXFIELDNAMES_W(Self: TIBTABLE; const T: STRING);
begin Self.INDEXFIELDNAMES := T; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLEINDEXFIELDNAMES_R(Self: TIBTABLE; var T: STRING);
begin T := Self.INDEXFIELDNAMES; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLEINDEXDEFS_W(Self: TIBTABLE; const T: TINDEXDEFS);
begin Self.INDEXDEFS := T; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLEINDEXDEFS_R(Self: TIBTABLE; var T: TINDEXDEFS);
begin T := Self.INDEXDEFS; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLEDEFAULTINDEX_W(Self: TIBTABLE; const T: BOOLEAN);
begin Self.DEFAULTINDEX := T; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLEDEFAULTINDEX_R(Self: TIBTABLE; var T: BOOLEAN);
begin T := Self.DEFAULTINDEX; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLETABLENAMES_R(Self: TIBTABLE; var T: TSTRINGS);
begin T := Self.TABLENAMES; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLEINDEXFIELDS_W(Self: TIBTABLE; const T: TFIELD; const t1: INTEGER);
begin Self.INDEXFIELDS[t1] := T; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLEINDEXFIELDS_R(Self: TIBTABLE; var T: TFIELD; const t1: INTEGER);
begin T := Self.INDEXFIELDS[t1]; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLEINDEXFIELDCOUNT_R(Self: TIBTABLE; var T: INTEGER);
begin T := Self.INDEXFIELDCOUNT; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLEEXISTS_R(Self: TIBTABLE; var T: BOOLEAN);
begin T := Self.EXISTS; end;

(*----------------------------------------------------------------------------*)
procedure TIBTABLECURRENTDBKEY_R(Self: TIBTABLE; var T: TIBDBKEY);
begin T := Self.CURRENTDBKEY; end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_TIBTABLE(CL: TIFPSRuntimeClassImporter);
begin
  with CL.Add(TIBTABLE) do
  begin
    RegisterMethod(@TIBTABLE.ADDINDEX, 'ADDINDEX');
    RegisterMethod(@TIBTABLE.CREATETABLE, 'CREATETABLE');
    RegisterMethod(@TIBTABLE.DELETEINDEX, 'DELETEINDEX');
    RegisterMethod(@TIBTABLE.DELETETABLE, 'DELETETABLE');
    RegisterMethod(@TIBTABLE.EMPTYTABLE, 'EMPTYTABLE');
    RegisterMethod(@TIBTABLE.GETINDEXNAMES, 'GETINDEXNAMES');
    RegisterMethod(@TIBTABLE.GOTOCURRENT, 'GOTOCURRENT');
    RegisterPropertyHelper(@TIBTABLECURRENTDBKEY_R,nil,'CURRENTDBKEY');
    RegisterPropertyHelper(@TIBTABLEEXISTS_R,nil,'EXISTS');
    RegisterPropertyHelper(@TIBTABLEINDEXFIELDCOUNT_R,nil,'INDEXFIELDCOUNT');
    RegisterPropertyHelper(@TIBTABLEINDEXFIELDS_R,@TIBTABLEINDEXFIELDS_W,'INDEXFIELDS');
    RegisterPropertyHelper(@TIBTABLETABLENAMES_R,nil,'TABLENAMES');
    RegisterPropertyHelper(@TIBTABLEDEFAULTINDEX_R,@TIBTABLEDEFAULTINDEX_W,'DEFAULTINDEX');
    RegisterPropertyHelper(@TIBTABLEINDEXDEFS_R,@TIBTABLEINDEXDEFS_W,'INDEXDEFS');
    RegisterPropertyHelper(@TIBTABLEINDEXFIELDNAMES_R,@TIBTABLEINDEXFIELDNAMES_W,'INDEXFIELDNAMES');
    RegisterPropertyHelper(@TIBTABLEINDEXNAME_R,@TIBTABLEINDEXNAME_W,'INDEXNAME');
    RegisterPropertyHelper(@TIBTABLEMASTERFIELDS_R,@TIBTABLEMASTERFIELDS_W,'MASTERFIELDS');
    RegisterPropertyHelper(@TIBTABLEMASTERSOURCE_R,@TIBTABLEMASTERSOURCE_W,'MASTERSOURCE');
    RegisterPropertyHelper(@TIBTABLEREADONLY_R,@TIBTABLEREADONLY_W,'READONLY');
    RegisterPropertyHelper(@TIBTABLESTOREDEFS_R,@TIBTABLESTOREDEFS_W,'STOREDEFS');
    RegisterPropertyHelper(@TIBTABLETABLENAME_R,@TIBTABLETABLENAME_W,'TABLENAME');
    RegisterPropertyHelper(@TIBTABLETABLETYPES_R,@TIBTABLETABLETYPES_W,'TABLETYPES');
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_IBTable(CL: TIFPSRuntimeClassImporter);
begin
  with CL.Add(TIBTABLE) do
  RIRegister_TIBTABLE(CL);
end;

 
 
{ TIFPS3CE_IBTable }
(*----------------------------------------------------------------------------*)
procedure TIFPS3CE_IBTable.CompOnUses(CompExec: TIFPS3CompExec);
begin
  { nothing } 
end;
(*----------------------------------------------------------------------------*)
procedure TIFPS3CE_IBTable.ExecOnUses(CompExec: TIFPS3CompExec);
begin
  { nothing } 
end;
(*----------------------------------------------------------------------------*)
procedure TIFPS3CE_IBTable.CompileImport1(CompExec: TIFPS3CompExec);
begin
  SIRegister_IBTable(CompExec.Comp);
end;
(*----------------------------------------------------------------------------*)
procedure TIFPS3CE_IBTable.CompileImport2(CompExec: TIFPS3CompExec);
begin
  { nothing } 
end;
(*----------------------------------------------------------------------------*)
procedure TIFPS3CE_IBTable.ExecImport1(CompExec: TIFPS3CompExec; const ri: TIFPSRuntimeClassImporter);
begin
  RIRegister_IBTable(ri);
end;
(*----------------------------------------------------------------------------*)
procedure TIFPS3CE_IBTable.ExecImport2(CompExec: TIFPS3CompExec; const ri: TIFPSRuntimeClassImporter);
begin
  { nothing } 
end;
 
 
initialization
 (**) 
{$IFDEF USEIMPORTER}
CIImporter.AddCallBack(@SIRegister_IBTable,PT_ClassImport);
{$ENDIF}
finalization
 (**) 
 
end.
