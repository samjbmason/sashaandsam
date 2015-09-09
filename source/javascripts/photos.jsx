var Photo = React.createClass({
  render: function() {
    return (
      <div className="photo">
        <div className="photo__container">
          <img src={this.props.img} />
          <h2 className="photo__user">
            <img className="photo__user-pic" src={this.props.user.profile_picture} />
            {this.props.user.username}
          </h2>
        </div>
      </div>
    );
  }
});

var PhotoList = React.createClass({
  loadPhotosFromServer: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'jsonp',
      cache: false,
      success: function(data) {
        this.setState({data: data.data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  getInitialState: function() {
    return {data: []};
  },
  componentDidMount: function() {
    this.loadPhotosFromServer();
    // setInterval(this.loadPhotosFromServer, this.props.pollInterval);
  },
  render: function() {
    if(this.state.data.length != 0) {
      var photoList = this.state.data.map(function(photo){
  			return(
  				<Photo img={photo.images.standard_resolution.url} key={photo.id} user={photo.user} />
  			)
  		});
      return (
        <div className="photo__list">
          {photoList}
        </div>
      );
    } else {
      return (
        <h2 className="photo__nothing-yet">You're a bit early, why not share a photo with the hashtag #masondecaires</h2>
      );
    }
  }
});

React.render(<PhotoList url="https://api.instagram.com/v1/tags/masondecaires/media/recent?client_id=ccab49481c8143309899266e5b17e2c0" pollInterval="2000" />, document.getElementById('r-photos'));