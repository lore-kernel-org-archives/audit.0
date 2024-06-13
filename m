Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EEB14B95B
	for <audit@vger.kernel.org>; Thu, 13 Jun 2024 22:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718317096; cv=none; b=qlqduEBSA52g1glXYSeCpIgU7wJQRvuD5bnsx9MBhNr8lIMzbEvIVRtECxnbIvGf7V528Tm6EAyQzWGRyuTuPd2iVp/fFvdRmq32nEPL/SnNAtVoT+ecde4LEtn8Erf3umqw+gAuxlG9mxK/KJmAK53vBjStl3V+W3ClBveKzxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718317096; c=relaxed/simple;
	bh=GspCeXbe53JYdKAHLrPNjz5Bk3zxp4umRvOyOhKibSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hq6U90eyeEvt8yMECYwNrRFqHep/Bl4yha/t06xYamh5zqEgQKHscXtBqOyj67KSwU7UHYafHFZnezJ5QLSCjSumIAOhQgAbnnaFmtqpQdAv+YEkI5o5vm9owAA3Y6Rky892cWlTv931y0EQ+syX4van9LqJSFkoblQ6m3qCdb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=T2tnF733; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T2tnF733"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52c819f6146so2257954e87.1
        for <audit@vger.kernel.org>; Thu, 13 Jun 2024 15:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718317093; x=1718921893; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ivv8xxFePEFaIPZc0G+v3++kMFBsUSKEIP1k/xbjdQI=;
        b=T2tnF733UAe9Y4nUwJuReNyBT6Fm2MMTW67nnizZbHZ3KuzfIPIvCoyBPY9wd2gIW9
         ZmdTgiU70M8jF9OFVtKsaJesy6RZILjIhvlSaSOHyqT9xAd5YPTAL+J0YRvGspOG82fv
         lqvxHt9ZY2ES90gmIk8dR3pkhUFZvDgEHVkNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718317093; x=1718921893;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ivv8xxFePEFaIPZc0G+v3++kMFBsUSKEIP1k/xbjdQI=;
        b=mQK6InPmwTOs3rUfrzp4iaZdqmK58Gr2SoZhAn+MHfXjGAM8A32hVWmX++Nt16/hmH
         ScbCKrQSuzy2kL+dMMBXjp54FOw5t9XWSGhapuoVwb2EACq/bP8uGYtAKE38PszRBkxl
         gpYYxhD4DlYNILR0aGuv4+eE6MfVyjUJvi+2yFrgAsneaVDEZqHMFayPs7eK2Ms0/vcv
         yRvvV59FyYpdZh+P4IM3LhuRemweHzEOGhpIKvXkWNjzkICy5y9+rMWvcHnnT6aN7i0I
         ojaduUvouYD3KEmuIs/VRultTXWJev+vdR7m+MQdAuhN6mf90JgSp4yMhvngDLD/Sthv
         FUaA==
X-Forwarded-Encrypted: i=1; AJvYcCW2vPUB6ydVVchDfgjGyFwFoP92CdPELdgWY9sCwmtE8jDcPw9HRP9B72TKhF5tSFZbwmnJm6YoJbXnuacGYRqYF+6uCLA=
X-Gm-Message-State: AOJu0Yz0PVV1taf8r/aKqHvJImxYCyhLrkW0mxhqqNXdWMsIJtl2ztLw
	MHN8ycJ1GWgqwwd8ocXFYvEVupMIemRCv/6xKwtqh27EHwwIG8THAjB1vbcNqDPzldsnjaeNv7N
	hrlZ4sA==
X-Google-Smtp-Source: AGHT+IFB7l0uF3DpQGcG9N5aeT3dZE7PRzkz3iiTdkIHQyG/hVfrFezPqKmCbYn6knpVuTdC1qSPtg==
X-Received: by 2002:ac2:4218:0:b0:52c:97d0:bf8e with SMTP id 2adb3069b0e04-52ca6e6bfa5mr591251e87.38.1718317092885;
        Thu, 13 Jun 2024 15:18:12 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282dd4asm349359e87.64.2024.06.13.15.18.10
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 15:18:11 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec10324791so3239501fa.1
        for <audit@vger.kernel.org>; Thu, 13 Jun 2024 15:18:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlR8Cn2qL9ZK9nVGZsJkIYStM/yeEX2m8uRA8+ZQKIzxdJvHo3prFAMqcRMPbJTpOoXeD2/uF73bNg+k9CTm9LHmA7QsU=
X-Received: by 2002:a2e:92d6:0:b0:2eb:242b:652a with SMTP id
 38308e7fff4ca-2ec0e5c6ce9mr6646061fa.15.1718317090589; Thu, 13 Jun 2024
 15:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613023044.45873-1-laoar.shao@gmail.com> <20240613023044.45873-6-laoar.shao@gmail.com>
 <20240613141435.fad09579c934dbb79a3086cc@linux-foundation.org>
In-Reply-To: <20240613141435.fad09579c934dbb79a3086cc@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Jun 2024 15:17:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqrwFXK-CO8-V4fwUh5ymnUZ=wJnFyufV1dM9rC1t3Lg@mail.gmail.com>
Message-ID: <CAHk-=wgqrwFXK-CO8-V4fwUh5ymnUZ=wJnFyufV1dM9rC1t3Lg@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] mm/util: Fix possible race condition in kstrdup()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 14:14, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> The concept sounds a little strange.  If some code takes a copy of a
> string while some other code is altering it, yes, the result will be a
> mess.  This is why get_task_comm() exists, and why it uses locking.

The thing is, get_task_comm() is terminally broken.

Nobody sane uses it, and sometimes it's literally _because_ it uses locking.

Let's look at the numbers:

 - 39 uses of get_task_comm()

 - 2 uses of __get_task_comm() because the locking doesn't work

 - 447 uses of raw "current->comm"

 - 112 uses of raw 'ta*sk->comm' (and possibly

IOW, we need to just accept the fact that nobody actually wants to use
"get_task_comm()". It's a broken interface. It's inconvenient, and the
locking makes it worse.

Now, I'm not convinced that kstrdup() is what anybody should use
should, but of the 600 "raw" uses of ->comm, four of them do seem to
be kstrdup.

Not great, I think they could be removed, but they are examples of
people doing this. And I think it *would* be good to have the
guarantee that yes, the kstrdup() result is always a proper string,
even if it's used for unstable sources. Who knows what other unstable
sources exist?

I do suspect that most of the raw uses of 'xyz->comm' is for
printouts. And I think we would be better with a '%pTSK' vsnprintf()
format thing for that.

Sadly, I don't think coccinelle can do the kinds of transforms that
involve printf format strings.

And no, a printk() string still couldn't use the locking version.

               Linus
