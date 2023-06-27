INSERT INTO [Subsidized Loans] (
    [School Name],
    [Recipients_DL_Subsidized],
    [Number of Loans Originated_DL_Subsidized],
    [Amount of Loans Originated_DL_Subsidized],
    [Number of Disbursements_DL_Subsidized],
    [Amount of Disbursements_DL_Subsidized],
    [Year]
)
SELECT distinct
    [School],
    [Recipients_DL_Subsidized],
    [Number_of_Loans_Originated_DL_Subsidized],
    [Amount_of_Loans_Originated_DL_Subsidized],
    [Number_of_Disbursements_DL_Subsidized],
    [Amount_of_Disbursements_DL_Subsidized],
    [Year]
FROM
    denormalized_dataset;

INSERT INTO [Unsubsidized Loans-Undergrad] (
    [School Name],
    [Recipients_DL_Unsubsidized_Undergrad],
    [Number of Loans Originated_DL_Unsubsidized_Undergrad],
    [Amount of Loans Originated_DL_Unsubsidized_Undergrad],
    [Number of Disbursements_DL_Unsubsidized_Undergrad],
    [Amount of Disbursements_DL_Unsubsidized_Undergrad],
    [Year]
)
SELECT distinct
    [School],
    [Recipients_DL_Unsubsidized_Undergrad],
    [Number_of_Loans_Originated_DL_Unsubsidized_Undergrad],
    [Amount_of_Loans_Originated_DL_Unsubsidized_Undergrad],
    [Number_of_Disbursements_DL_Unsubsidized_Undergrad],
    [Amount_of_Disbursements_DL_Unsubsidized_Undergrad],
    [Year]
FROM
    denormalized_dataset;

INSERT INTO [Unsubsidized Loans-Graduate] (
    [School Name],
    [Recipients_DL_Unsubsidized_Graduate],
    [Number of Loans Originated_DL_Unsubsidized_Graduate],
    [Amount of Loans Originated_DL_Unsubsidized_Graduate],
    [Number of Disbursements_DL_Unsubsidized_Graduate],
    [Amount of Disbursements_DL_Unsubsidized_Graduate],
    [Year]
)
SELECT distinct
    [School],
    [Recipients_DL_Unsubsidized_Graduate],
    [Number_of_Loans_Originated_DL_Unsubsidized_Graduate],
    [Amount_of_Loans_Originated_DL_Unsubsidized_Graduate],
    [Number_of_Disbursements_DL_Unsubsidized_Graduate],
    [Amount_of_Disbursements_DL_Unsubsidized_Graduate],
    [Year]
FROM
    denormalized_dataset;

INSERT INTO [Parent Plus Loan] (
    [School Name],
    [Recipients_DL_Parent_Plus],
    [Number of Loans Originated_DL_Parent_Plus],
    [Amount of Loans Originated_DL_Parent_Plus],
    [Number of Disbursements_DL_Parent_Plus],
    [Amount of Disbursements_DL_Parent_Plus],
    [Year]
)
SELECT distinct
    [School],
    [Recipients_DL_Parent_Plus],
    [Number_of_Loans_Originated_DL_Parent_Plus],
    [Amount_of_Loans_Originated_DL_Parent_Plus],
    [Number_of_Disbursements_DL_Parent_Plus],
    [Amount_of_Disbursements_DL_Parent_Plus],
    [Year]
FROM
    denormalized_dataset;

INSERT INTO [Graduate Plus Loan] (
    [School Name],
    [Recipients_DL_Grad_Plus],
    [Number of Loans Originated_DL_Grad_Plus],
    [Amount of Loans Originated_DL_Grad_Plus],
    [Number of Disbursements_DL_Grad_Plus],
    [Amount of Disbursements_DL_Grad_Plus],
    [Year]
)
SELECT distinct
    [School],
    [Recipients_DL_Grad_Plus],
    [Number_of_Loans_Originated_DL_Grad_Plus],
    [Amount_of_Loans_Originated_DL_Grad_Plus],
    [Number_of_Disbursements_DL_Grad_Plus],
    [Amount_of_Disbursements_DL_Grad_Plus],
    [Year]
FROM
    denormalized_dataset;

INSERT INTO [Pell Grant] (
    [School Name],
    [Pell Recipients],
    [Pell Disbursements],
    [Year]
)
SELECT distinct
    [School],
    [Pell_Recipients],
    [Pell_Disbursements],
    [Year]
FROM
    denormalized_dataset;

INSERT INTO [Location] (
[State]
)
SELECT distinct
    [State]
FROM
    denormalized_dataset;

INSERT INTO [Institution Type] (
[School Type]
)
SELECT distinct
    [School_Type]
FROM
    denormalized_dataset;

INSERT INTO Institution(
    [OPE ID],
    [School Name],
    [Year],
    institution_typeID,
    locationID
)
SELECT
    denorm.[OPE_ID],
    denorm.[School],
    denorm.[Year],
    institution_typeID,
    locationID
    
FROM
    denormalized_dataset AS denorm
left JOIN [Institution Type] ON denorm.[School_Type] = [Institution Type].[School Type]
left JOIN [Location] ON denorm.[State] = [Location].[State];



INSERT INTO [Institution Subsidized Loans Bridge] (institutionID, subsidizedID)
SELECT i.[institutionID], s.[subsidizedID]
FROM Institution i
JOIN [Subsidized Loans] s ON i.[School Name] = s.[School Name] AND i.[Year] = s.[Year];


INSERT INTO [Institution Unsubsidized Loans-Graduate Bridge] (institutionID, unsubsidized_graduateID)
SELECT i.[institutionID], s.[unsubsidized_graduateID]
FROM Institution i
JOIN [Unsubsidized Loans-Graduate] s ON i.[School Name] = s.[School Name] AND i.[Year] = s.[Year];


INSERT INTO [Institution Parent Plus Loans Bridge] (institutionID, parent_plusID)
SELECT i.[institutionID], s.[parent_plusID]
FROM Institution i
JOIN [Parent Plus Loan] s ON i.[School Name] = s.[School Name] AND i.[Year] = s.[Year];


INSERT INTO [Institution Graduate Plus Loans Bridge] (institutionID, graduate_plusID)
SELECT i.[institutionID], s.[graduate_plusID]
FROM Institution i
JOIN [Graduate Plus Loan] s ON i.[School Name] = s.[School Name] AND i.[Year] = s.[Year];


INSERT INTO [Institution Unsubsidized Loans-Undergrad Bridge] (institutionID, unsubsidized_undergradID)
SELECT i.[institutionID], s.[unsubsidized_undergradID]
FROM Institution i
JOIN [Unsubsidized Loans-Undergrad] s ON i.[School Name] = s.[School Name] AND i.[Year] = s.[Year];


INSERT INTO [Institution Pell Grant Bridge] (institutionID, pell_grantID)
SELECT i.[institutionID], s.[pell_grantID]
FROM Institution i
JOIN [Pell Grant] s ON i.[School Name] = s.[School Name] AND i.[Year] = s.[Year];