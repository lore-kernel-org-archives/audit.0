Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179714A02
	for <audit@vger.kernel.org>; Wed, 18 Mar 2026 01:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773796573; cv=pass; b=djgTc6UaH7GqBbfkb5Wg4JjVoW88O+FQU6dnb4mX696Yri5mlvAjBa5qhBv5B87YD4VTstHgPdNpEsI6nEAkoYGvlPsebmf7ZsHE/yQ4CfbJV2fE6kU4/1hXaWRWGrv8a7Tk/M/svUZgLrBJNleDzWZmpeollgitkO/HG4Z8XwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773796573; c=relaxed/simple;
	bh=3w2OBXZSRP6xgeoDfIzydCPozvN6W2306MSC+T9kb58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tE+58aaWGIlP2b6BURleueyqv+Yz6PHo1noE9JSbxa3SPf2V0pBd/x/KEJxXp1rKUy6GAsSY97ki0kuR2RKIAk/A7GhhW8XafPOBr6uv1U6xNFSRmBus5s7p3OAUe647E3BoGu4gfraV8yTFaFm7oT79KUF/fddYEKNGIweL6Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwNbXNsF; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwNbXNsF"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48628ce9ab5so18232295e9.2
        for <audit@vger.kernel.org>; Tue, 17 Mar 2026 18:16:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773796570; cv=none;
        d=google.com; s=arc-20240605;
        b=UrfC4sQBO6dGAK+ddBPa+yfFu7RzqiyuDKhyhROdDASrS9e3SfU3FwYcBfDr18MRVr
         vg5n8QZB5Ukaa7ZtHADXgypTzvWIk5SEzXOn1y83HNZyngEAbQ1zCoIwsjHkCiMR7075
         O2Zdll1a2K/8pkuJcl65wSKGQE78dLFpeeYcTnJc41PpVF3P0zVB1fyJ6AnKavZdbUM0
         4pChtsT6IB0Odsb3gS81E7oa/nIqFS7g0F3V4YCSGFhke03yK9LaKuHHZFXDQPyTlYjM
         wwp/v9mg2rq7J4ie21AWS9FNc1m018rpkqlxGP64hqyo8HXL8SXk8ias8vOFhDPBsqW9
         edWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3w2OBXZSRP6xgeoDfIzydCPozvN6W2306MSC+T9kb58=;
        fh=vtw62oZfMC63g0hTqMjpNpKjbNvyoJy5eXdMMkTaqy0=;
        b=BP1JjknjqsFBhu3Yw5PqmoEvJLd4VTLnzlY6fkRRmFxCW3HWiISoPlBZKxFxC66H4o
         0qoNkmrmJ19BL3uuBPa74ghkNYLVFJdltj2p45dvrk/GeinwsWrsZgjSZTuPINWukdU+
         KLY6bZcydLGrA6ajgWxlzR/OqXvVszpTa49HQHoeIGAHfZpmZQSmafHcA4rYeIH/QYnp
         0O5LjP4oe1mM2lbN42lRedC8yWioiYzyN7i5vHCVyqsMTxMP2AIH1gpguDxZGZKgNsAv
         DYT+yEDa112GYDfv4LBeK5OOhCBU/ovx/A7QkmcXcn0/gArzpPzf+u5YgTNX+X4Ds6hy
         Jabg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773796570; x=1774401370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3w2OBXZSRP6xgeoDfIzydCPozvN6W2306MSC+T9kb58=;
        b=gwNbXNsFjJ5I/rKMUtQV0RcE8uzPvaeiGNXV9yRrfF3jsU2WqReVgITC+rdJf4VWId
         2Q3Wqy/4mb4oFtqwNXgTNf7ZTX0ty08lzY2QTNj9GK/iIt66kbgevofTQrx5LqnOnkUF
         xtfRftDGYI3Gg1HBpFa7CDJNx61668vS20asflQgQydFp8SGyRylv6mASjCoxy8RqG4T
         cFRESowjz2A+czTkSOlFp/Z2hFQ5LEQoRrBwq6oP7W8iHZY6AnCybUmUCY4uS3N3mUzQ
         rg7nSjsC+DpBj5jWYS+4EENc7UWuqQPT+Xqxn0jJF8r6mqjyRoLCS1SaWpIAEc49hKCA
         AQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773796570; x=1774401370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3w2OBXZSRP6xgeoDfIzydCPozvN6W2306MSC+T9kb58=;
        b=CXSxXubzHXR0CHed4drgFIY2CwOXBEpOE+4WJbiJLW6faEBGMCkdUrbGX4TqWlZPIE
         V6Mb/7Qyi1CI6nKqLuv6W18slgtj86tpOhZxRW2a8lUGTT9VWZNxbHEoVW75/3JUtKir
         Zn/R78EDzCCzPgXHGOe865EAwDjqwij1+aP6XdWx5InzurckWU3J1lbl0IU+qrwxBoQg
         RLG6VXoYVFDNcQuKPJuLIrZR2/ifRwOUiavJVW3AS/UjoIk1xmBgWuMKsbCUFOt8tbJw
         lrY3M2RdKrpybxq3zdtw0gzQBomghe2Y/A9x22pjkdlRaHFISpU1SZsC0n4OaLa7mnR1
         Djmg==
X-Forwarded-Encrypted: i=1; AJvYcCX+0QqzhMmeKV1yrZqaxW7JtL4bYxoghhj++BfZQaZV1ygQiv9LElmrFN43wZBrcMroLCVjWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBboxH+GeZp2Mn8R52qepwsyee5efmRNM0qvgCN969bymOy5jD
	U1Lvwm+wZlOSVbxi9VSgAdsEXBlkNRtw1sEMzT+mqsljEXfQHJ5yPtVVO5xZGMmYxFU9efiNeuH
	E/6UplAlRnJlvBEi5JFy4folJzZ3VyMc=
X-Gm-Gg: ATEYQzzp/cgp2x+415mT5GpeQK+M6DxEJ2oUWrXp81I7TSjuJ3JLum6xvto8Wnf+cTF
	ljE9Q0oiy04WSRkjcwCrJGMn73keuzz4gdfQV724LXhaH98eEuU3JKEEywdYt+g/dRzt4UuCF45
	Fk3wq+audv1hW3Hlz0v+5MkBP7HIQlAcCwvGch2Cc7AWJRU4GaKGWKD6LwAokL6yaovGOkeHROY
	sqDcGd8NMT0O9D7R/8j7o6rAktlzxItnyVtXppfBx8gdhsISydb5U70FZ4y+xU8FRpgHWGzsgYw
	0hWZlsy6EN3zz/PkSH+K7DmgBMoSEYljIR+/F5E7kDOtzbiyfLvP/dd3GotSsRGJEJoYouyY34E
	Mo3ZtWdlAXheuBJ9muP8cXZjf5Q==
X-Received: by 2002:a05:600c:8683:b0:485:f1d1:8f3d with SMTP id
 5b1f17b1804b1-486f442e6e5mr18435595e9.6.1773796570321; Tue, 17 Mar 2026
 18:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <CAP01T77VyW=5SHDvM3HXPNHaxRdzs8H__MOh2zx1dQ6STeAUtg@mail.gmail.com>
In-Reply-To: <CAP01T77VyW=5SHDvM3HXPNHaxRdzs8H__MOh2zx1dQ6STeAUtg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Mar 2026 18:15:59 -0700
X-Gm-Features: AaiRm52ZhrulSIFyNHNiIzRvMopWhhEYRIriCdPJwA716TKmoKnUrKQyqpBcyns
Message-ID: <CAADnVQJCJaLjGCwjCX9VtT615c4kn7v5bxviUmGFVj=uTtUHMg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF LSM
 programs via BPF kfuncs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Frederick Lawler <fred@cloudflare.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, audit@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 7:44=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, 11 Mar 2026 at 22:31, Frederick Lawler <fred@cloudflare.com> wrot=
e:
> >
> > The motivation behind the change is to give BPF LSM developers the
> > ability to report accesses via the audit subsystem much like how LSMs
> > operate today.

Sure, but bpf lsm-s don't need to follow such conventions.
audit is nothing but a message passing from kernel to user space
and done in a very inefficient way by wrapping strings into skb/netlink.
bpf progs can do this message passing already via various ways:
perfbuf, ringbuf, streams.
Teach your user space to consume one of them.
