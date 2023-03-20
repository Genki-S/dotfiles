let g:projectionist_heuristics = {
			\ '*.go': {
			\   '*.go': {
			\     'alternate': '{}_test.go',
			\     'type': 'source'
			\   },
			\   '*_test.go': {
			\     'alternate': '{}.go',
			\     'type': 'test'
			\   },
			\ },
			\ 'project.godot': {
			\   '*.gd': {
			\     'alternate': 'test/unit/{dirname}/test_{basename}.gd',
			\     'type': 'source'
			\   },
			\   'test/unit/**/test_*.gd': {
			\     'alternate': '{dirname}/{basename}.gd',
			\     'type': 'test'
			\   },
			\ }}
