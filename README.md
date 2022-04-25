> Contest IWLS 2022 ☕️👋

### 🏠 [Homepage](https://github.com/pntmatheus/IWLS2022#readme)

## Documentation: File Pattern (Results_João)
```bash
$> <TOOL_Current>_<previous_tool/format>
$> The last tool is always in capital letters

Example: 
	1> ABC_espresso 
		takes the output Espresso and loads it into the ABC tool

	2> AIGER_abc_espresso
		takes the abc output, which was generated from the Espresso output, and loads it into the AIGER tool
```

## Results_Ammes Folders:
```bash
$> aigs_tt
$> aigs_espresso:
	1> aigs: Initial aigs generated direct from the truth table.
	2> aigs_dc2: Aigs optimized with optimize_aig_dc2 script.
	3> aigs_resyn2: Aigs optimizes with optimize_aig_resyn2 script.
	4> aigs_sep: Aigs optimizes with optimize_aig_dc2_resyn2_mfs script.
	5> aigs_alt: Aigs optimizes with optimize_aig_dc2_resyn2_mfs_alt script.
```
	
## Results_Ammes Scripts:
```bash
$> optimize_aig_dc2 script: Optimize each aig on aigs folder with dc2 until no gain is obtained for 10 iterations.
$> optimize_aig_resyn2 script: Optimize each aig on aigs folder with resyn2 until no gain is obtained for 10 iterations.
$> optimize_aig_alt: Optimize each aig on aigs folder applying dc2 and resyn2 in an alternate way until no gain is obtained for 10 iterations.
$> optimize_aig_dc2_resyn2_mfs script: Optimize each aig with optimize_aig_dc2 script, then with optimize_aig_resyn2 script, then apply the abc commands "logic;mfs -C 0 -W #level -D 0 -M 0 -L #level -d -r -e;st", where #level is the number of levels. Executes this sequence until no gain is obtained for 10 iterations.
$> optimize_aig_dc2_resyn2_mfs_alt script: Optimize each aig with optimize_aig_alt script, then apply the abc commands "logic;mfs -C 0 -W #level -D 0 -M 0 -L #level -d -r -e;st", where #level is the number of levels. Executes this sequence until no gain is obtained for 10 iterations.

```
