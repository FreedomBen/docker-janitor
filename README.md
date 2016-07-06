# Docker Janitor

## Why do I need a janitor?

Ever notice how docker leaves behind Gigabytes and Gigabytes worth of junk
on your hard drive?  Me too, and I need that space back!  Enter Docker Janitor

Docker is an aggressive cacher.  This saves you _a lot_ of time on rebuilds,
which is important because it saves you a lot of time.  However, it can often
leave your disk full of old cache objects that you don't really need anymore.

## My drive is full!  How do I fix it?

Well good sir or madam, you're in the right place.  All you need is this gem.

```
gem install docker_janitor
```

Then run it!

### Usage

```
Commands:
  docker-janitor clean           # Clean up leftover docker cruft (does containers, images, volumes)
  docker-janitor containers      # Delete exited containers
  docker-janitor help [COMMAND]  # Describe available commands or one specific command
  docker-janitor images          # Delete unlabeled imaged
  docker-janitor volumes         # Delete orphaned volumes

Options:
  dry-run, d, [--dryrun], [--no-dryrun]
```

### What does all that mean?

Well there are 3 places docker-janitor looks for junk.  Containers that have
exited, images that are unlabeled, and volumes that are orphaned.  To clean everything:

```
docker-janitor clean
```

If you don't make regular and disciplined use of the `--rm` flag with docker and
docker-compose, you can end up with a lot of containers lying around that ran and
exited.  Chances are you will never need these again (tho sometimes you do, so pay
attention to the caveat).  By keeping them around, you waste disk space.
Furthermore, you lock the image that they're based on so it can't be cleaned up.
The caveat is that *if you have data-only containers or containers that store
data, you will lose that data if you delete/clean them*.  To fix this, you should
mount a volume into the container that includes the data.  This way data persists
after a container is deleted/recreated.  If you want to protect against
unintentional deletion of a container, add a regex to `~/docker-janitor.yml`
(this file can be generating with `docker-janitor config-file`.

To clean only stopped containers:

```
docker-janitor containers
```

or

```
docker-janitor clean --containers
```

Unlabeled images can also take up a lot of space.  These are often leftover
from previous builds (which docker caches aggressively).  If you've changed
the `Dockerfile` or source in any way, these images will never be used again.
This happens a lot when you're writing Dockerfiles.

To clean only unlabeled images:

```
docker-janitor images
```

or

```
docker-janitor clean --images
```

Orphaned volumes are the result of containers that have been deleted.
To avoid data loss, docker will not remove the volume.  However, if you've
deleted the container, you've probably left a volume behind.

To clean only orphaned volumes:

```
docker-janitor volumes
```

or

```
docker-janitor clean --volumes
```
