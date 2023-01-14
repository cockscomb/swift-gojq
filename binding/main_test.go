package binding

import (
	"reflect"
	"testing"
)

func TestQuery_Run(t *testing.T) {
	type args struct {
		input string
		query string
	}
	tests := []struct {
		name    string
		args    args
		want    []string
		wantErr bool
	}{
		{
			name: "simple",
			args: args{
				input: `{"foo": "bar"}`,
				query: `.foo`,
			},
			want: []string{
				`"bar"`,
			},
		},
		{
			name: "array",
			args: args{
				input: `[{"foo": "bar"}, {"foo": "bar"}]`,
				query: `.[].foo`,
			},
			want: []string{
				`"bar"`,
				`"bar"`,
			},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			q, _ := NewQuery(tt.args.query)
			iter, err := q.Run([]byte(tt.args.input))
			if (err != nil) != tt.wantErr {
				t.Errorf("Run() error = %v, wantErr %v", err, tt.wantErr)
				return
			}
			var got []string
			for {
				v, err := iter.Next()
				if err != nil {
					break
				}
				got = append(got, string(v))
			}
			if !reflect.DeepEqual(got, tt.want) {
				t.Errorf("Run() got = %v, want %v", got, tt.want)
			}
		})
	}
}
