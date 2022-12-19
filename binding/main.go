package binding

import "fmt"

func Greetings(name string) string {
	return fmt.Sprintf("Hello, %s!", name)
}
