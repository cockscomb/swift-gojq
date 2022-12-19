package binding

import (
	"encoding/json"
	"github.com/itchyny/gojq"
	"io"
)

type Query struct {
	query *gojq.Query
}

func NewQuery(src string) (*Query, error) {
	query, err := gojq.Parse(src)
	if err != nil {
		return nil, err
	}
	return &Query{query: query}, nil
}

func (q *Query) Run(input []byte) (*Iterator, error) {
	var v any
	if err := json.Unmarshal(input, &v); err != nil {
		return nil, err
	}

	iter := q.query.Run(v)
	return &Iterator{iter: iter}, nil
}

type Iterator struct {
	iter gojq.Iter
}

func (i *Iterator) Next() ([]byte, error) {
	v, ok := i.iter.Next()
	if !ok {
		return nil, io.EOF
	}
	if err, ok := v.(error); ok {
		return nil, err
	}
	return json.Marshal(v)
}
