Sub Multi_Year_Stock_Data()


Dim WS As Worksheet
    For Each WS In ActiveWorkbook.Worksheets
    WS.Activate
        LastRow = WS.Cells(Rows.Count, 1).End(xlUp).Row

        'Variables
        
        Dim Open_Price As Double
        Dim Close_Price As Double
        Dim Yearly_Change As Double
        Dim Ticker_Name As String
        Dim Percent_Change As Double
        Dim Volume As Double
        Volume = 0
        Dim Row As Double
        Dim Column As Integer
        Column = 1
        Row = 2
        Dim i As Long
        
        'Column Title
        Cells(1, 9).Value = "Ticker"
        Cells(1, 10).Value = "Yearly Change"
        Cells(1, 11).Value = "Percent Change"
        Cells(1, 12).Value = "Total Stock Volume"
        
                    
         ' OP
         Open_Price = Cells(2, Column + 2).Value
         
         For i = 2 To LastRow
         
         ' Compare and Contrast Ticker Names
            If Cells(i + 1, Column).Value <> Cells(i, Column).Value Then
                
                ' Ticker name
                Ticker_Name = Cells(i, Column).Value
                Cells(Row, Column + 8).Value = Ticker_Name
                
                '  CP
                Close_Price = Cells(i, Column + 5).Value
                
                ' YC
                Yearly_Change = Close_Price - Open_Price
                Cells(Row, Column + 9).Value = Yearly_Change
                
                ' PC
                
                If (Open_Price = 0 And Close_Price = 0) Then
                    Percent_Change = 0
                
                ElseIf (Open_Price = 0 And Close_Price <> 0) Then
                    Percent_Change = 1
                
                Else
                    Percent_Change = Yearly_Change / Open_Price
                    Cells(Row, Column + 10).Value = Percent_Change
                    Cells(Row, Column + 10).NumberFormat = "0.00%"
                
                End If
                
                ' Calculate Total Volume
                Volume = Volume + Cells(i, Column + 6).Value
                Cells(Row, Column + 11).Value = Volume
                
                Row = Row + 1
            
                Open_Price = Cells(i + 1, Column + 2)
                Volume = 0
        
            
            Else
                Volume = Volume + Cells(i, Column + 6).Value
            
            End If
        
        Next i
        
        ' YC
        YCLastRow = WS.Cells(Rows.Count, Column + 8).End(xlUp).Row
        
        ' Conditional Formatting
        
        For i = 2 To YCLastRow
            
            If (Cells(i, Column + 9).Value > 0 Or Cells(i, Column + 9).Value = 0) Then
                
                Cells(i, Column + 9).Interior.ColorIndex = 4
            
            ElseIf Cells(i, Column + 9).Value < 0 Then
                
                Cells(i, Column + 9).Interior.ColorIndex = 3
            
            End If
        
        Next i
        
  Next WS
  
End Sub
