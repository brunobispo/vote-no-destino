class Answer extends React.Component {
  constructor(props){
    super(props);
    this.state = {current: 1, contestant: 0};
    this.options = this.props.options.slice();
  }

  handleChoose(choice){
    const greater = choice == this.state.current;

    if (!greater && this.state.contestant > 0) {
      this.setState((state) => ({contestant: state.contestant - 1}));
      return;
    }

    const current = this.options.splice(this.state.current, 1)[0];
    this.options.splice(this.state.contestant + 1, 0, current);
  
    if (this.state.current < this.options.length - 1) {
      this.setState((state) => ({
        current: state.current + 1,
        contestant: state.current,
      }));
    } else {
      alert('end of game');
    }

  }

  render(){
    if (this.state.current < this.options.length - 1) {
      const option1 = this.options[this.state.current];
      const option2 = this.options[this.state.contestant];
      return (
        <Question key={this.state.current+this.state.contestant} id={this.state.current+this.state.contestant} onChoose={this.handleChoose.bind(this)}>
          <Option name={option1.name} imageUrl={option1.image_url} id={this.state.current}/>
          <Option name={option2.name} imageUrl={option2.image_url} id={this.state.contestant}/>
        </Question>
      );
    } else {
      return <p>{I18n.t('show_result')}</p>
    }
  }
}

Answer.propTypes = {
  options: React.PropTypes.arrayOf(React.PropTypes.object),
}