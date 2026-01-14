Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710F7393DE2
	for <audit@vger.kernel.org>; Wed, 14 Jan 2026 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387321; cv=none; b=HrlsxRyo5sZ708JCyXCdz4J6OdG8pkrJsV9izR2R/dhsPmO4USay8vSThpS2agOv/0p5hFYNfW5MVE4wxYosCCUpV5+I8689juJ3xtsqlIIn3ntzBNGhYAvuXhYzNbgu+tzI7CcJdYusxU+TuJByK7LhhfREqijP3L/BcH17fCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387321; c=relaxed/simple;
	bh=i4yytTNmVkmFiF7VhC12SD5qcVKeMJU0ABCzZO/63xY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzcwS7+rch6teid+MW1RKH6n5CxqqD5YtRnFkCse2a00UKBs27+pY+2wSjHKn770etvJz83Rat8fonVylsZiFPkpCl3LF1WzNJhDpGT4e9O6knHYYKM6KBht98Q1bRRV8ZagZ8DWeACYMWW0CxQHfkx0106vId0JemrfslTD0F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/qJeu6H; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/qJeu6H"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-430f9ffd4e8so314285f8f.0
        for <audit@vger.kernel.org>; Wed, 14 Jan 2026 02:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768387318; x=1768992118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Lk7QsQj8+PnAUAXKejIhRlWfGoAntY1XiyL3gVs6yI=;
        b=R/qJeu6HoJthZFgQ5jwvjuATd3NFsmZb0XPMd/3F+SxJRrh2rPEO9ILbrihFG86CxY
         kxJlueg7RZwNhdTfsnCtnEE9JqKk2U6nbDWV9wqX3DJZHmEq2eISv4piq6rXKkCduOW7
         nNCFB7Zn5HO9slncITH8kfyBBWlbvmhBLSxTLSE6JduzvNTqSkagb7PIC+hzNJdLHLai
         XU0zf5tjMPqOHLUjVsf8EWQThT4XU/eKfioSn8paOW38Ux+tHVkKPBUvUXHkuiC0nHDD
         /YBEI954s7ocE6RUUoOxS3s7Uh8aL4DKkSytJJ79+gA2uPCWRiFQFe45iXBeTeK5W4qE
         E04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768387318; x=1768992118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Lk7QsQj8+PnAUAXKejIhRlWfGoAntY1XiyL3gVs6yI=;
        b=JJy6PRFzQxUZc7GL6zTfLp+r/Aagr9+UUnFNaRiYNIIxrO+JRJlMzGTAybZMS6I84T
         RI/QZhdJpmPfjoXrzQX8mNGDRJXtzkO372jlXDK4Tlm7c49tlUfX1HVuIx7r77aPqA7v
         RRIIcYJ1cuc0lsGmYhHLZIUtNLcSQemRT6vcmBtZjodThEti2XXutbn2aBIsaxT4YYpc
         NN9mQPlYsrcaIPZTeO/0n40mLjNn1YEEcHPCNiwkeMJVWi+/H+hYc2UYsLkYZ/XI5VmW
         v2oikmE/xFXGJrnZDVb2roW3eX8jZmDMrBCZB4cBG87tlL1ViSy5JLtt5LCpH9UlQ+ZI
         Z2hA==
X-Forwarded-Encrypted: i=1; AJvYcCV7dGKhIQfQQ2m0/HdYZwAu4z3TmLWGLh/4udnIccCa3Gg9sH/jU5K/jDe7McO37/GVV5tPcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUGvVpznPlHJN+Fv/S0s66BXMje/kFY2a26P1Cvyqsw36VjYxL
	DpO2vTvKAsKlpa/6H9jC6Dn+MLsFhg7/ZOKlerXIA136Kf9gESLP99Wq
X-Gm-Gg: AY/fxX63mgaCVRYRA4FHB3zWNklWxU39ruYfmU6nu/Uux8kojm/Q8hiQaI+WH39uifw
	xtdrDlSZJeRXjUqy98waxVL7dml5SAXdyTu+LdnbGoNB3dyXBeLxi4QbLmUX2rXoLwIEPhR1iPE
	ZDdsZ7UXkx5/IvJVnqma7is1k2AXHx1VE/v8JX17NfArAcz7AX2pBOx6STJWuF8jQBvmZueBEsw
	2vf6yePAW+LIz6FETWWyQ7wnlqriqbUwQU4kCxxrEIxWZedJBkT4C0wV8z/1M3yfSdqe3I03vBU
	Fmtj0I4tZNDxZRctPDiu8WStABDJ8+gYQHNt++AyT3JdPL+wkQHsiGVh/u+f1fCCpQzfZAqmaW8
	0OFfS81QAwm/31TGKjd6e4oLWTEDeJt1ypy9DV00RtOv+jdP0aB9I9BzExqWTItU3NrOJhHHHee
	XM1KqPSlO67Kzj50q8b63uZEAWoR1MiIE9lmvMZOhAjgEBwBGxnLnl
X-Received: by 2002:a05:600c:1c02:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-47ee37a440bmr25926025e9.10.1768387317582;
        Wed, 14 Jan 2026 02:41:57 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee5910fc2sm20776235e9.13.2026.01.14.02.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 02:41:57 -0800 (PST)
Date: Wed, 14 Jan 2026 10:41:55 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Mateusz Guzik <mjguzik@gmail.com>, Paul Moore
 <paul@paul-moore.com>, Jens Axboe <axboe@kernel.dk>, audit@vger.kernel.org,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 68/68] sysfs(2): fs_index() argument is _not_ a
 pathname
Message-ID: <20260114104155.708180fc@pumpkin>
In-Reply-To: <20260114043310.3885463-69-viro@zeniv.linux.org.uk>
References: <20260114043310.3885463-1-viro@zeniv.linux.org.uk>
	<20260114043310.3885463-69-viro@zeniv.linux.org.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 04:33:10 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> ... it's a filesystem type name.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/filesystems.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/filesystems.c b/fs/filesystems.c
> index 95e5256821a5..0c7d2b7ac26c 100644
> --- a/fs/filesystems.c
> +++ b/fs/filesystems.c
> @@ -132,24 +132,21 @@ EXPORT_SYMBOL(unregister_filesystem);
>  static int fs_index(const char __user * __name)
>  {
>  	struct file_system_type * tmp;
> -	struct filename *name;
> +	char *name __free(kfree) = strndup_user(__name, PATH_MAX);
>  	int err, index;
>  
> -	name = getname(__name);
> -	err = PTR_ERR(name);
>  	if (IS_ERR(name))
> -		return err;
> +		return PTR_ERR(name);

Doesn't that end up calling kfree(name) and the check in kfree() doesn't
seem to exclude error values.

Changing:
#define ZERO_OR_NULL_PTR(x) ((unsigned long)(x) <= \
				(unsigned long)ZERO_SIZE_PTR)
to:
#define ZERO_OR_NULL_PTR(x) (4096 + (unsigned long)(x) <= \
				4096 + (unsigned long)ZERO_SIZE_PTR)
would fix it at minimal cost.

	David


>  
>  	err = -EINVAL;
>  	read_lock(&file_systems_lock);
>  	for (tmp=file_systems, index=0 ; tmp ; tmp=tmp->next, index++) {
> -		if (strcmp(tmp->name, name->name) == 0) {
> +		if (strcmp(tmp->name, name) == 0) {
>  			err = index;
>  			break;
>  		}
>  	}
>  	read_unlock(&file_systems_lock);
> -	putname(name);
>  	return err;
>  }
>  

